*** Settings ***
Library    CamundaLibrary    ${CAMUNDA_HOST}

*** Variables ***
${CAMUNDA_HOST}    ${EMPTY}
${TOPIC}    name_of_my_camunda_topic

# Task variables
${WORKLOAD}    ${EMPTY}
${PROCESS_INSTANCE}    ${EMPTY}
${TASK_RESULT}    ${EMPTY}

*** Keywords ***
Check and download workload
    [Arguments]    ${counter}
    ${potential_workload}    Fetch Workload    ${TOPIC}
    ${process_instance_from_response}    Get fetch response
    Pass Execution If    not ${process_instance_from_response}     No workload found. Amount of workloads processed in total: ${counter}
    Set Global Variable    ${WORKLOAD}    ${potential_workload}
    Set Global Variable    ${PROCESS_INSTANCE}    ${process_instance_from_response}

Do processing
    Log    Place processing of the following workload here:\n${WORKLOAD}

Finish workload
    Complete task    ${TASK_RESULT}

*** Tasks ***
Process workload
    FOR    ${counter}    IN RANGE    0    100
        Check and download workload    ${counter}
        Do processing
        Finish workload
    END

