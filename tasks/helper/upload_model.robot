*** Settings ***
Library    CamundaLibrary    host=${CAMUNDA_URL}

*** Variables ***
${CAMUNDA_URL}    http://localhost:8080
${MODEL_FILE}    ${CURDIR}/../../models/coffee_model.bpmn

*** Task ***
Upload model to Camunda 7
    ${response}=    Deploy    ${MODEL_FILE}
    Log To Console    ${response}