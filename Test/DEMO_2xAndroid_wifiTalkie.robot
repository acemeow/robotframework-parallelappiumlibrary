*** Settings ***
Library           ../src/ParalleAppiumLib.py
Library           runKeywordAsync
Suite Setup  keywords_test_setup
Suite Teardown  keywords_test_teardown



*** Test Cases ***

chat
    ${thread1}=    Run Keyword Async    PA_EP7337JFDK
    ${thread2}=    Run Keyword Async    PA_HQ51FYL18100
    ${END}=    Wait Async All    600


waits
    Comment    wait_until_page_contains_accessibility_id
    wait_until_page_contains_xpath    0    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[3]
    Comment    wait_until_page_contains_id    0    com.remaller.android.wifitalkie_lite:id/sendMessageButton

*** Keywords ***

keywords_test_setup
    setServerCount    2
    addInstance    HQ51FYL18100    4010    4011    Android    4.4.2    com.remaller.android.wifitalkie_lite    talkie.core.activities.main.CoreActivity
    addInstance    EP7337JFDK    4030    4031    Android    4.3    com.remaller.android.wifitalkie_lite    talkie.core.activities.main.CoreActivity
    startServers    true


keywords_test_teardown
    stopAppiumServers

AcceptEULA_EnterchatRoom
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/acceptCheckBox
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/submitButton

    Comment    click_element_by_xpath    0    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]
    Comment    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/button_messages

PA_EP7337JFDK
    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/acceptCheckBox
    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/submitButton
    Comment    Wait Until Page Contains Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    sleep    5s
    click_element_by_xpath    1    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    sleep    3s
    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/button_files
    sleep    3s
    click_element_by_xpath    1    /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.support.v7.widget.RecyclerView/android.widget.LinearLayout[1]/android.widget.LinearLayout
    sleep    1s
    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/itemCheckBox
    sleep    1s
    comment    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/bottomBarDoneButton
    click_element_by_accessibility_id    1    更多選項
    click_element_by_xpath    1    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    sleep    3s
    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/button_messages
    sleep    3s
    input_text_by_id    0    com.remaller.android.wifitalkie_lite:id/messageEditText    WOOF!
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/sendMessageButton
    sleep    3s


PA_HQ51FYL18100
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/acceptCheckBox
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/submitButton
    sleep    5s
    click_element_by_xpath    0    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]
    sleep    3s
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/button_messages
    sleep    15s
    Comment    wait_until_page_contains_id    0    com.remaller.android.wifitalkie_lite:id/declineButton    10
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/declineButton
    input_text_by_id    0    com.remaller.android.wifitalkie_lite:id/messageEditText    MEOW!
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/sendMessageButton
