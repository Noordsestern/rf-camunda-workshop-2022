*** Settings ***
Library    CamundaLibrary    ${CAMUNDA_HOST}
Variables    variables/camunda.py

*** Variables ***
${TOPIC}    prepare coffee

# Task variables
${WORKLOAD}    ${EMPTY}
${PROCESS_INSTANCE}    ${EMPTY}

*** Keywords ***
Check and download workload
    [Arguments]    ${counter}
    ${potential_workload}    Fetch Workload    ${TOPIC}
    ${process_instance_from_response}    Get fetch response
    Pass Execution If    not $process_instance_from_response     No more workload found. Amount of workloads processed in total: ${counter}
    Set Global Variable    ${WORKLOAD}    ${potential_workload}
    Set Global Variable    ${PROCESS_INSTANCE}    ${process_instance_from_response}

Do processing
    Log To Console   Preparing for you: ${WORKLOAD}[coffee_type]
    Sleep    2 s

Finish workload
    Complete task

*** Tasks ***
Process workload to prepare coffee
    [Tags]    30
    FOR    ${counter}    IN RANGE    0    100
        Check and download workload    ${counter}
        Do processing
        Finish workload
    END

