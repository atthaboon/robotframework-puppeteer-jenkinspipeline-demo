*** Settings ***
Library    PuppeteerLibrary
Force Tags    SMT_1
Test Teardown    Close All Browser
Suite Teardown    Close Puppeteer
    

*** Test Cases ***
Demo SMT_1
    Open browser to test page    https://www.w3schools.com/
    Capture Page Screenshot    

*** Keywords ***
Open browser to test page
    [Arguments]    ${url}
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${url}    browser=chrome   options=${options}
