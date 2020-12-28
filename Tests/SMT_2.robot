*** Settings ***
Library    PuppeteerLibrary
Force Tags    SMT_2
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
