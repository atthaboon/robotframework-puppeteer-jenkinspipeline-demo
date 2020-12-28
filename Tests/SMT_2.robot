*** Settings ***
Library    PuppeteerLibrary
Force Tags    SMT-2
Test Teardown    Close All Browser
Suite Teardown    Close Puppeteer    

*** Test Cases ***
Demo SMT_2
    Open browser to test page    https://www.google.com
    Capture Page Screenshot    

*** Keywords ***
Open browser to test page
    [Arguments]    ${url}
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${url}    browser=chrome   options=${options}
    ${SS_PATH} =    Get Variable Value    ${ARGS_SS_PATH}    ${None}
    Return From Keyword If    '${SS_PATH}' == '${None}'
    Set Screenshot Directory    ${OUTPUT DIR}
