*** Settings ***
Library    CamundaLibrary    host=${CAMUNDA_URL}

*** Variables ***
${CAMUNDA_URL}    http://localhost:8080
${MODEL_FILE}    ${CURDIR}/../../models/coffee_model.bpmn
${FORM_FILE}    ${CURDIR}/../../models/fix_coffee.form

*** Task ***
Upload model to Camunda 7
    ${response}=    Deploy    ${MODEL_FILE}    ${FORM_FILE} 
    Log To Console    ${response}