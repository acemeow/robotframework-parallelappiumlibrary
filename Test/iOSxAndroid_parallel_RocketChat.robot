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
    addInstance    607dd2124bfe2b5f95929539bf41e68265009de7    4020    4021    iOS    10.3.3    acetest.chat.rocket.ios    .MainActivity    None    SSJ3AAN8C8
    addInstance    EP7337JFDK    4030    4031    Android    4.3    chat.rocket.android    .activity.MainActivity
    startServers    true

iOS_thread
    sleep    10s
    click_element_by_xpath    0    //XCUIElementTypeButton[@name="Go"]
    sleep    20s
    input_text_by_xpath    0    //XCUIElementTypeApplication[@name="Rocket.Chat+"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeTextField    acetesting.a@gmail.com
    sleep    5s
    input_text_by_xpath    0    //XCUIElementTypeApplication[@name="Rocket.Chat+"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeSecureTextField    acetest0000
    sleep    20s
    click_element_by_xpath    0    //XCUIElementTypeButton[@name="Go"]
    sleep    10s
    input_text_by_xpath    0    //XCUIElementTypeApplication[@name="Rocket.Chat+"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeToolbar/XCUIElementTypeTextView    hello
    click_element_by_xpath    0    //XCUIElementTypeButton[@name="Send"]

Android_thread
    sleep    10s
    click_element_by_id    1    chat.rocket.android:id/btn_connect
    sleep    20s
    input_text_by_id    1    chat.rocket.android:id/editor_username    acetestingB
    input_text_by_id    1    chat.rocket.android:id/editor_passwd    acetest1234
    click_element_by_id    1    chat.rocket.android:id/btn_login_with_email
    sleep    10s
    click_element_by_id    1    chat.rocket.android:id/drawee_avatar
    click_element_by_id    1    chat.rocket.android:id/userStatus
    sleep    10s
    input_text_by_id    1    chat.rocket.android:id/editor    hi
    click_element_by_id    1    chat.rocket.android:id/button_send

keywords_test_teardown
    comment    stopAppiumServers



