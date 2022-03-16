*** Settings ***
Library    CamundaLibrary
Resource    ../commons.resource
Variables    ${task_folder}/variables/camunda.py
Suite Setup    Set Camunda URL    ${CAMUNDA_HOST}

*** Variables ***
${task_folder}    ${CURDIR}/../../tasks/20_get_coffee_ingredients

*** Test Cases ***
Validate process state
    Given Process 'coffee_brewing' is not empty
    Then Process is ready at "prepare coffee"
