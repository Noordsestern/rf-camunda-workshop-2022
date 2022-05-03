*** Settings ***
Library    CamundaLibrary
Resource    ../commons.resource
Variables    ${task_folder}/variables/camunda.py
Variables    testdata.py
Suite Setup    Set Camunda URL    ${CAMUNDA_HOST}

*** Variables ***
${task_folder}    ${CURDIR}/../../tasks/30_prepare_coffee

*** Test Cases ***
Validate process state after task 'Prepare Coffee'
    [Tags]    30
    Given Process 'coffee_brewing' is not empty
    FOR    ${testset}    IN    @{test_data}   
        ${testcase}    Set Variable      ${testset}[testcase] 
        ${expected_activity_ids}    Set Variable    ${testset}[validate][activity_ids]
        Then Process is ready   ${testcase}    ${expected_activity_ids}
    END
