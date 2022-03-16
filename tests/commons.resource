*** Settings ***
Library    CamundaLibrary
Library    RequestsLibrary
Library    json
Library    Collections

*** Keywords ***
Process is deployed
    ${existing_process_definition}    Get Process Definitions    key=coffee_brewing
    IF    not ${existing_process_definition}
        Deploy    ${model_folder}/coffee_model.bpmn
    END
    ${existing_process_definition}    Get Process Definitions    key=coffee_brewing
    Should Not Be Empty    ${existing_process_definition}    Process is not deployed

Process starts    
    [Arguments]    ${testset}
    ${process_key}    Set Variable    ${testset}[process_key]
    ${variables}    Set Variable    ${testset}[prepare][variables]
    ${before_activity_id}    Set Variable    ${testset}[prepare][activity_ids][0]
    ${business_key}    Set Variable    ${testset}[testcase]
    Start process     ${process_key}   variables=${variables}    before_activity_id=${before_activity_id}   business_key=${business_key}

Process starts at "${activity_id}"
    ${variables}    Create Dictionary    coffee_type=Espresso
    Start process    coffee_brewing    variables=${variables}    before_activity_id=${activity_id}

Get Active Process Instance for Test Cases
    [Arguments]    ${testcase}
    ${process_instances}    Get process instances    business_key=${testcase}    active=true
    Should Not be empty    ${process_instances}    Could not find process instance for testcase:\t${testcase}
    Length Should Be    ${process_instances}    1
    ${process_instance}    Set Variable    ${process_instances}[0]
    [Return]    ${process_instance}

Process is ready
    [Arguments]    ${testcase}    @{expected_activity_ids}
    ${process_instance}    Get Active Process Instance for Test Cases    ${testcase}
    ${activity_instance}    Get Activity Instance    ${process_instance}[id]
    Should Not be Empty    ${activity_instance}    No activity instance retreived for process instance:\t${process_instance}
    ${child_activity_instances}    Set Variable    ${activity_instance}[child_activity_instances]
    FOR    ${child_activity}    IN    @{child_activity_instances}
        IF    '${child_activity}[activity_type]' == 'serviceTask'
            List Should Contain Value    @{expected_activity_ids}    ${child_activity}[activity_id]    Unexpected service task:\t${child_activity}[activity_id]
        END
    END

Process should contain variables
    [Arguments]    ${testcase}    ${expected_variables}
    ${process_instance}    Get Active Process Instance for Test Cases    ${testcase}
    FOR    ${key}    ${expected_value}    IN    &{expected_variables}
        ${value}    Get Process Instance Variable    ${process_instance}[id]    ${key}
        Should Be Equal    ${expected_value}    ${value}
    END

Process is ready at "${topic}"
    ${count_workload}    Count process instances at "${topic}"
    Should Be Equal As Integers    ${count_workload}    1    There should be only 1 process instance be available at topic '${topic}'
    
Count process instances at "${topic}"
    ${response}    GET    ${CAMUNDA_HOST}/engine-rest/external-task/count
    ${message}    loads    ${response.text}
    Should Not Be Empty    ${message}
    Dictionary Should Contain Key    ${message}    count
    [Return]    ${message}[count]
    
Process '${process_key}' is empty
    ${process_instances}    Get all active process instances    ${process_key}
    IF    ${process_instances}
        FOR    ${instance}    IN    @{process_instances}
            Delete process instance    ${instance}[id]
        END
        ${process_instances}    Get all active process instances    ${process_key}
    END
    Should Be Empty    ${process_instances}    Failed to empty process '${process_key}'

Process '${process_key}' is not empty
    ${process_instances}    Get all active process instances    ${process_key}
    Should Not Be Empty    ${process_instances}    Failure, process is empty: '${process_key}'