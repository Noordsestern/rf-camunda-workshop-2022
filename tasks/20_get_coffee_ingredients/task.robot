*** Settings ***
Library    CamundaLibrary
Resource    keywords/recipes.resource
Variables    variables/camunda.py
# Variables are only available *after* Libraries are initialized, therefore we need to configurate Camunda URL after library loading, too.
Suite Setup    Set Camunda URL    ${CAMUNDA_HOST}
Task Teardown    Handle result

*** Variables ***

# Constants
@{COFFEE_ENDPOINTS}    https://api.sampleapis.com/coffee/hot     https://api.sampleapis.com/coffee/iced

# Task variables
${WORKLOAD}    ${EMPTY}
${PROCESS_INSTANCE}    ${EMPTY}
${INGREDIENTS}    ${EMPTY}

*** Keywords ***
Check and download workload
    [Arguments]    ${counter}
    ${potential_workload}    Fetch Workload    ${TOPIC}
    ${process_instance_from_response}    Get fetch response
    Pass Execution If    not $process_instance_from_response     No workload found. Amount of workloads processed in total: ${counter}
    Set Global Variable    ${WORKLOAD}    ${potential_workload}
    Set Global Variable    ${PROCESS_INSTANCE}    ${process_instance_from_response}



Finish workload
    IF    $INGREDIENTS
        ${variables}    Create Dictionary    ingredients=${INGREDIENTS}
        Complete task    ${variables}
    ELSE
       Throw BPMN Error    error_code=COFFEE_TYPE_UNKNOWN    error_message=Failed to identify ingredients for '${WORKLOAD}[coffee_type]'
    END
    
Handle result
    Run Keyword If Test Failed    Notify failure    retries==3    message=${TEST_MESSAGE}

*** Tasks ***
Process workload for getting coffee ingredients
    [Tags]    20
    FOR    ${counter}    IN RANGE    0    100
        Check and download workload    ${counter}
        Get ingredients
        Finish workload
    END

