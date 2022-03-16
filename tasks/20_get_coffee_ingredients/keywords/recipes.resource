*** Settings ***
Library    RequestsLibrary
Library    json
Library    ../libraries/CoffeeApi.py
Library    Collections


*** Keywords ***
Get ingredients
    ${recipes}    Collect recepies
    ${recipe}    Identify coffee from recipes    ${WORKLOAD}[coffee_type]    ${recipes}
    Should Not Be Empty    ${recipe}    Could not find a recipe for ${WORKLOAD}[coffee_type]
    ${ingredients}    Get From Dictionary    ${recipe}    ingredients
    Set Global Variable    ${ingredients}
    [Return]    ${ingredients}


Collect recepies
    ${response}    GET   https://api.sampleapis.com/coffee/hot
    ${coffee_recipes}    loads    ${response.text}
    [Return]    ${coffee_recipes}