*** Settings ***
Library    CamundaLibrary    ${CAMUNDA_HOST}
Library    RequestsLibrary
Library    json
Library    libraries/CoffeeApi.py
Library    Collections

*** Variables ***
${CAMUNDA_HOST}    %{CAMUNDA_HOST}
${TOPIC}    name_of_my_camunda_topic

# Task variables
${WORKLOAD}    ${EMPTY}
${PROCESS_INSTANCE}    ${EMPTY}
${TASK_RESULT}    ${EMPTY}
${INGREDIENTS}    ${EMPTY}

*** Keywords ***
Check and download workload
    [Arguments]    ${counter}
    ${potential_workload}    Fetch Workload    ${TOPIC}
    ${process_instance_from_response}    Get fetch response
    Pass Execution If    not ${process_instance_from_response}     No workload found. Amount of workloads processed in total: ${counter}
    Set Global Variable    ${WORKLOAD}    ${potential_workload}
    Set Global Variable    ${PROCESS_INSTANCE}    ${process_instance_from_response}

Get ingredients
    ${recipes}    Collect recepies
    ${recipe}    Identify coffee from recipes    ${WORKLOAD}[coffee_type]    ${recipes}
    ${ingredients}    Get From Dictionary    ${recipe}    ingredients
    Set Global Variable    ${ingredients}
    [Return]    ${ingredients}


Collect recepies
    ${response}    GET   https://api.sampleapis.com/coffee/hot
    ${coffee_recipes}    loads    ${response.text}
    [Return]    ${coffee_recipes}

Finish workload
    IF    ${INGREDIENTS}
        ${variables}    Create Dictionary    ingredients=${INGREDIENTS}
        Complete task    ${TASK_RESULT}
    ELSE
       Throw BPMN Error    error_code=COFFEE_TYPE_UNKNOWN    error_message=Failed to identify ingredients for '${WORKLOAD}[coffee_type]'
    END

*** Tasks ***
Process workload
    #Check and download workload    ${counter}
    ${WORKLOAD}    Create Dictionary    coffee_type    Black
    Set Global Variable    ${WORKLOAD}
    Get ingredients
    #Finish workload

