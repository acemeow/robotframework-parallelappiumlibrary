*** Settings ***
Documentation     Single thread testing on all keywords
Library           ../src/ParalleAppiumLib.py
Suite Setup  keywords_test_setup
Suite Teardown  keywords_test_teardown

*** Test Cases ***

login
    sleep    3s
    goToURL    0    https://www.google.com/gmail/
    sleep    10s
    input_text_by_id    0    identifierId    acetesting.a@gmail.com
    sleep    5s
    click_element_by_xpath    0    //*[@id='identifierNext']/content/span
    input_text_by_xpath    0    //*[@id='password']/div[1]/div/div[1]/input   acetest0000
    comment    input_text_by_class_name    0    android.widget.EditText    acetest0000
    sleep    3s
    click_element_by_xpath    0    //*[@id='passwordNext']/content/span
    sleep    10s
    click_element_by_xpath    0    //*[@id='tltbt']/div[4]
    sleep    5s
    input_text_by_xpath    0    //*[@id='composeto']    acetesting.b@gmail.com
    sleep    5s
    input_text_by_xpath    0    //*[@id='cmcsubj']    testmail
    input_text_by_xpath    0    //*[@id='cmcbody']    hello
    click_element_by_xpath    0    //*[@id='cvtbt']/div[4]/div

*** Keywords ***
keywords_test_setup
    setServerCount    1
    Comment    addInstance    HQ51FYL18100    4020    4021    Android    4.4.2
    ...    com.remaller.android.wifitalkie_lite    com.remaller.talkie.core.CoreActivity
    Comment    addInstance    607dd2124bfe2b5f95929539bf41e68265009de7    4023    4024    iOS    10.3.3    safari    SSJ3AAN8C8
    addInstance    607dd2124bfe2b5f95929539bf41e68265009de7    4020    4021    iOS    10.3.3    None    None    safari    SSJ3AAN8C8

    startServers    true

keywords_test_teardown
    stopAppiumServers



