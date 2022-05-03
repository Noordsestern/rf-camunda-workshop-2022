*** Settings ***
Library    CamundaLibrary
Resource    ../commons.resource
Variables    ${task_folder}/variables/camunda.py
Variables    testdata.py
Suite Setup    Set Camunda URL    ${CAMUNDA_HOST}

*** Variables ***
${task_folder}    ${CURDIR}/../../tasks/30_prepare_coffee
${model_folder}    ${CURDIR}/../../models


*** Test Cases ***
Prepare task Execution 'Prepare Coffee'
    [Tags]    30
    Given Process is deployed
    And Process 'coffee_brewing' is empty
    FOR    ${testset}    IN    @{test_data}     
        When Process starts    ${testset}
        Then Process is ready   ${testset}[testcase]    ${testset}[prepare][activity_ids]
    END