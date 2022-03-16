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

Process starts at "${activity_id}"
    ${variables}    Create Dictionary    coffee_type=Espresso
    Start process    coffee_brewing    variables=${variables}    before_activity_id=${activity_id}

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