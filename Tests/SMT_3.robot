*** Settings ***
Library    PuppeteerLibrary
Force Tags    SMT-3
Test Teardown    Close All Browser
Suite Teardown    Close Puppeteer    

*** Test Cases ***
Demo SMT_3
    Open browser to test page    https://www.w3schools.com/html/default.asp
    Capture Page Screenshot    

*** Keywords ***
Open browser to test page
    [Arguments]    ${url}
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${url}    browser=chrome   options=${options}
    ${SS_PATH} =    Get Variable Value    ${ARGS_SS_PATH}    ${None}
    Return From Keyword If    '${SS_PATH}' == '${None}'
    Set Screenshot Directory    ${OUTPUT DIR}/${SS_PATH} 
