*** Settings ***
Library    CamundaLibrary
Resource    ../commons.resource
Variables    ${task_folder}/variables/camunda.py
Suite Setup    Set Camunda URL    ${CAMUNDA_HOST}

*** Variables ***
${task_folder}    ${CURDIR}/../../tasks/20_get_coffee_ingredients
${model_folder}    ${CURDIR}/../../models


*** Test Cases ***
Prepare task Execution
    Given Process is deployed
    And Process 'coffee_brewing' is empty
    When Process starts at "robot_get_ingredients"
    Then Process is ready at "${TOPIC}"