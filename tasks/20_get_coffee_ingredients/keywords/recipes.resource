*** Settings ***
Library    RequestsLibrary
Library    json
Library    ../libraries/CoffeeApi.py
Library    Collections
Library    XML


*** Keywords ***
Get ingredients
    ${recipes}    Collect recepies
    ${recipe}    Identify coffee from recipes    ${WORKLOAD}[coffee_type]    ${recipes}
    IF    ${recipe}
        ${ingredients_local}    Get From Dictionary    ${recipe}    ingredients
        Set Test Variable    ${ingredients}    ${ingredients_local}
    ELSE
        Log    Could not find a recipe for ${WORKLOAD}[coffee_type]    WARN
        Set Test Variable    ${ingredients}    ${EMPTY}
    END
    
    [Return]    ${ingredients}


Collect recepies
    ${response}    GET   https://api.sampleapis.com/coffee/hot
    ${coffee_recipes}    loads    ${response.text}
    [Return]    ${coffee_recipes}