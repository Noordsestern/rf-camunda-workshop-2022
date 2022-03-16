*** Settings ***
Library    CamundaLibrary
Resource    ../commons.resource
Variables    ${task_folder}/variables/camunda.py
Variables    testdata.py
Suite Setup    Set Camunda URL    ${CAMUNDA_HOST}

*** Variables ***
${task_folder}    ${CURDIR}/../../tasks/20_get_coffee_ingredients

*** Test Cases ***
Validate process state
    Given Process 'coffee_brewing' is not empty
    FOR    ${testset}    IN    @{test_data}   
        ${testcase}    Set Variable      ${testset}[testcase] 
        ${expected_activity_ids}    Set Variable    ${testset}[validate][activity_ids]
        ${expected_variables}    Set Variable    ${testset}[validate][variables]
        Then Process is ready   ${testcase}    ${expected_activity_ids}
        And Process should contain variables    ${testcase}    ${expected_variables}
    END
