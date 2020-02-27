*** Settings ***
Library  Collections
Library  SeleniumLibrary

*** Test Cases ***
Heroku Login chrome headless
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}   add_argument    headless
    Call Method    ${chrome_options}   add_argument    no-sandbox
    Call Method    ${chrome_options}   add_argument    disable-dev-shm-usage
    ${options}=     Call Method     ${chrome_options}    to_capabilities

    Open Browser  http://the-internet.herokuapp.com/login   browser=chrome  desired_capabilities=${options}
    Input Text  //input[@id='username']  tomsmith
    Input Text  //input[@id='password']  SuperSecretPassword!
    Click Button  Login
    Element Text Should be  //h4  Welcome to the Secure Area. When you are done click logout below.  Expected message is not shown
    Capture Page Screenshot
    Click Link  Logout
    Capture Page Screenshot