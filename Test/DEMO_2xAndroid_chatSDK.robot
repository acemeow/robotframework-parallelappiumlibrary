*** Settings ***
Library           ../src/ParalleAppiumLib.py
Library           runKeywordAsync
Suite Setup  keywords_test_setup
Suite Teardown  keywords_test_teardown

*** Test Cases ***

login

    ${thread1}=    Run Keyword Async    Android_thread1
    ${thread2}=    Run Keyword Async    Android_thread2
    ${END}=    Wait Async All    600


*** Keywords ***
keywords_test_setup
    setServerCount    2
    addInstance    HQ51FYL18100    4010    4011    Android    4.4.2    co.chatsdk.android.app    co.chatsdk.ui.login.LoginActivity
    addInstance    EP7337JFDK    4030    4031    Android    4.3    co.chatsdk.android.app    co.chatsdk.ui.login.LoginActivity
    startServers    true
    sleep    10s


Android_thread1
    sleep    15s
    input_text_by_id    0    co.chatsdk.android.app:id/chat_sdk_et_username    acetesting.a@gmail.com
    input_text_by_id    0    co.chatsdk.android.app:id/chat_sdk_et_password    acetest1234
    hide_keyboard    0
    click_element_by_id    0    co.chatsdk.android.app:id/chat_sdk_btn_login
    sleep    10s

    click_element_by_id    0    co.chatsdk.android.app:id/img_thread_image

    sleep    5s
    input_text_by_id    0    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    hi
    click_element_by_id    0    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message

    click_element_by_accessibility_id    0    Message option button
    click_element_by_xpath    0    /hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.ListView/android.widget.TextView[1]
    sleep    10s
    comment    click_element_by_id    0    com.google.android.gms:id/select_marker_location
    comment    click_element_by_xpath    0    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[1]/android.widget.FrameLayout/android.view.View/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]/android.widget.LinearLayout/android.widget.TextView[1]
    click_element_by_xpath    0    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[1]/android.widget.FrameLayout/android.view.View/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]
    sleep    5s
    click_element_by_id    0    com.google.android.gms:id/confirm_button

    comment    wait_until_page_contains_xpath    0    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.View/android.widget.FrameLayout[2]/android.widget.LinearLayout/android.widget.FrameLayout/android.view.View/android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[5]

    click_element_by_accessibility_id    0    Message option button
    click_element_by_xpath    0    /hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.ListView/android.widget.TextView[3]
    sleep    5s
    click_element_by_xpath    0    (//android.view.View[@content-desc="相片 (2016年5月31日)"])[4]
    sleep    5s
    click_element_by_id    0    co.chatsdk.android.app:id/btn_done
    sleep    120s
    input_text_by_id    0    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    WOOF!
    click_element_by_id    0    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message
    sleep    120s
    input_text_by_id    0    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    WOOF!!
    click_element_by_id    0    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message
    sleep    120s
    input_text_by_id    0    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    WOOF!!!
    click_element_by_id    0    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message
    sleep    10s

Android_thread2
    sleep    15s
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_username    acetesting.b@gmail.com
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_password    acetest1234
    click_element_by_id    1    co.chatsdk.android.app:id/chat_sdk_btn_login
    sleep    10s

    click_element_by_id    1    co.chatsdk.android.app:id/img_thread_image

    sleep    5s
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    hi
    click_element_by_id    1    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message

    click_element_by_accessibility_id    1    Message option button
    click_element_by_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.ListView/android.widget.TextView[1]
    sleep    10s
    comment    click_element_by_id    1    com.google.android.gms:id/select_marker_location
    comment    click_element_by_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[1]/android.widget.FrameLayout/android.view.View/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]/android.widget.LinearLayout/android.widget.TextView[1]
    click_element_by_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[1]/android.widget.FrameLayout/android.view.View/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[2]
    sleep    5s
    click_element_by_id    1    com.google.android.gms:id/confirm_button

    wait_until_page_contains_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.View/android.widget.FrameLayout[2]/android.widget.LinearLayout/android.widget.FrameLayout/android.view.View/android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[5]

    click_element_by_accessibility_id    1    Message option button
    click_element_by_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.ListView/android.widget.TextView[3]
    sleep    5s
    tap_coordinate    1    670    960    10
    sleep    5s
    click_element_by_id    1    co.chatsdk.android.app:id/btn_done
    sleep    120s
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    MEOW
    click_element_by_id    1    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message
    sleep    120s
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    MEOW?
    click_element_by_id    1    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message
    sleep    120s
    input_text_by_id    1    co.chatsdk.android.app:id/chat_sdk_et_message_to_send    MEOW????
    click_element_by_id    1    co.chatsdk.android.app:id/chat_sdk_btn_chat_send_message
    sleep    10s


keywords_test_teardown
    stopAppiumServers



