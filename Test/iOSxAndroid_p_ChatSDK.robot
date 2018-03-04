*** Settings ***
Library           ../src/ParalleAppiumLib.py
Library           runKeywordAsync
Suite Setup  keywords_test_setup
Suite Teardown  keywords_test_teardown

*** Test Cases ***

login

    ${thread1}=    Run Keyword Async    iOS_thread
    ${thread2}=    Run Keyword Async    Android_thread
    ${END}=    Wait Async All    300


*** Keywords ***
keywords_test_setup
    setServerCount    2
    addInstance    607dd2124bfe2b5f95929539bf41e68265009de7    4020    4021    iOS    10.3.3    com.acetesting.deluge.Chat-SDK    .MainActivity    None    SSJ3AAN8C8
    addInstance    EP7337JFDK    4030    4031    Android    4.3    co.chatsdk.android.app    co.chatsdk.ui.login.LoginActivity
    startServers    true
    sleep    10s


iOS_thread
    sleep   15s
    click_element_by_accessibility_id    0    ChatSDK97
    comment    input_text_by_accessibility_id    0    Write\ssomething...    hello
    input_text_by_xpath    0    //XCUIElementTypeStaticText[@name="Write something..."]    hello
    click_element_by_accessibility_id    0    Send

    click_element_by_xpath    0    //XCUIElementTypeButton[@name="icn 24 options"]
    click_element_by_accessibility_id    0    Location

    click_element_by_xpath    0    //XCUIElementTypeButton[@name="icn 24 options"]
    comment    click_element_by_accessibility_id    0    Choose Photo
    click_element_by_xpath    0    //XCUIElementTypeSheet[@name="Options"]/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[3]
    comment    tap_coordinate    0    150    400    3
    comment    click_element_by_xpath    0    //XCUIElementTypeButton[@name="Camera Roll"]
    click_element_by_xpath    0    //XCUIElementTypeCell[@name="Camera Roll"]
    click_element_by_xpath    0    (//XCUIElementTypeCell[@name="Photo, Landscape, 2017年12月29日 下午1:50"])[2]
    click_element_by_accessibility_id    0    Done

Android_thread
    sleep   15s
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_username    acetesting.b@gmail.com
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_password    acetest1234
    click_element_by_id    1    co.chatsdk.android.app:id/chat_sdk_btn_login
    sleep   10s

    click_element_by_id    1    co.chatsdk.android.app:id/img_thread_image

    sleep   5s
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    hi
    click_element_by_id    1    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message

    click_element_by_accessibility_id    1    Message option button
    click_element_by_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.ListView/android.widget.TextView[1]
    sleep   5s
    comment    click_element_by_id    1    com.google.android.gms:id/select_marker_location
    click_element_by_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[1]/android.widget.FrameLayout/android.view.View/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]
    sleep   5s
    click_element_by_id    1    com.google.android.gms:id/confirm_button

    wait_until_page_contains_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.View/android.widget.FrameLayout[2]/android.widget.LinearLayout/android.widget.FrameLayout/android.view.View/android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[5]

    click_element_by_accessibility_id    1    Message option button
    click_element_by_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.ListView/android.widget.TextView[3]
    sleep   5s
    tap_coordinate    1    670    960    10
    sleep   5s
    click_element_by_id    1    co.chatsdk.android.app:id/btn_done


keywords_test_teardown
    comment    stopAppiumServers



