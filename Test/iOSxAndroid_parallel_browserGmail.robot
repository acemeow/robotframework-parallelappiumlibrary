*** Settings ***
Library           ../src/ParalleAppiumLib.py
Library           runKeywordAsync
Suite Setup  keywords_test_setup
Suite Teardown  keywords_test_teardown

*** Test Cases ***

login

    ${thread1}=    Run Keyword Async    iOS_thread
    ${thread2}=    Run Keyword Async    Android_thread
    ${END}=    Wait Async All


*** Keywords ***
keywords_test_setup
    setServerCount    2
    addInstance    607dd2124bfe2b5f95929539bf41e68265009de7    4020    4021    iOS    10.3.3    None    None    Safari    SSJ3AAN8C8
    addInstance    EP7337JFDK    4030    4031    Android    4.3    None    None    chrome
    startServers    true

iOS_thread
    sleep    10s
    goToURL    0    https://www.google.com/gmail/
    sleep    5s
    click_element_by_xpath    0    //*[@id='tltbt']/div[4]/div
    sleep    5s
    input_text_by_xpath    0    //*[@id='composeto']    acetesting.b@gmail.com
    input_text_by_xpath    0    //*[@id='cmcsubj']    testmail
    input_text_by_xpath    0    //*[@id='cmcbody']    hello
    click_element_by_xpath    0    //*[@id='cvtbt']/div[4]/div

Android_thread
    sleep    10s
    goToURL    1    https://www.google.com/gmail/
    sleep    5s
    comment    input_text_by_accessibility_id    1    identifier    acetesting.b
    comment    input_text_by_id    1    identifierId    acetesting.b
    input_text_by_xpath    1    //*[@id='identifierId']    acetesting.b
    click_element_by_xpath    1    //*[@id='identifierNext']/content/span
    sleep    5s
    input_text_by_xpath    1    //*[@id='password']/div[1]/div/div[1]/input   acetest1234
    sleep    5s
    click_element_by_xpath    1    //*[@id='passwordNext']/content/span
    sleep    5s
    click_element_by_xpath    1    //*[@id='tltbt']/div[4]/div
    sleep    5s
    input_text_by_xpath    1    //*[@id='composeto']    acetesting.a@gmail.com
    input_text_by_xpath    1    //*[@id='cmcsubj']    testmail
    input_text_by_xpath    1    //*[@id='cmcbody']    Greetings
    click_element_by_xpath    1    //*[@id='cvtbt']/div[4]/div

keywords_test_teardown
    stopAppiumServers



