*** Settings ***
Library    Browser
Library    ../../venv/lib/python3.9/site-packages/robot/libraries/Collections.py
Suite Teardown    Close Browser

*** Tasks ***
Parse trip data
    Navigate to trip in Browser
    Parse trip data

*** Keywords ***
Navigate to trip in Browser
    New Page    https://www.intrepidtravel.com/eu/croatia/croatia-sailing-adventure-split-dubrovnik-109010#dates
    Click    xpath=//div[@id="date-list-view"]/div/button
    Sleep    1s
    Click    xpath=//div[@id="date-list-view"]/div/button
    Sleep    1s
    Take Screenshot

Parse trip data
    ${elements}    Get Elements    xpath=//div[@id="date-list-view"]/div[@class="departure-info-list"]//div[@class="info-date collapsed"]//div[@class="row"]
    ${tour_dates_raw}    Create List
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        Append To List    ${tour_dates_raw}    ${text}
    END
    # TODO : parse tour dates; must split raw dates by \n