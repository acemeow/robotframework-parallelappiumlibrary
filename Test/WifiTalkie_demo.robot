*** Settings ***
Library           runKeywordAsync
Library           ../src/ParalleAppiumLib.py

*** Variables ***
${HQ51FYL18100}    Open Application    http://localhost:4020/wd/hub    platformName=Android    platformVersion=4.4.2    deviceName=HQ51FYL18100    udid=HQ51FYL18100    automationName=appium
...               appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
${EP7337JFDK}     Open Application    http://localhost:4023/wd/hub    platformName=Android    platformVersion=4.3    deviceName=EP7337JFDK    udid=EP7337JFDK    automationName=appium
...               appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
${chat1}          hi
${chat2}          hello

*** Test Cases ***
exampleTest
    Log    Test Started
    Comment    ${HQ51FYL18100}=    Open Application    http://localhost:4020/wd/hub    platformName=Android    platformVersion=4.4.2    deviceName=HQ51FYL18100
    ...    udid=HQ51FYL18100    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    ${EP7337JFDK}    Open Application    http://localhost:4023/wd/hub    platformName=Android    platformVersion=4.3    deviceName=EP7337JFDK
    ...    udid=EP7337JFDK    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    setServerCount    2
    Comment    addServer    0    HQ51FYL18100    com.remaller.android.wifitalkie_lite    com.remaller.talkie.core.CoreActivity
    Comment    addServer    1    EP7337JFDK    com.remaller.android.wifitalkie_lite    com.remaller.talkie.core.CoreActivity
    Comment    startServer    HQ51FYL18100    4020    4021    4022
    Comment    startServer    EP7337JFDK    4023    4024    4025
    Comment    Open Application    http://localhost:4023/wd/hub    platformName=Android    platformVersion=4.3    deviceName=EP7337JFDK    udid=EP7337JFDK
    ...    automationName=appium    appPackage=com.netease.qa.orangedemo    appActivity=MainActivity
    ${thread1}    Run Async    Chat_HQ51FYL18100
    ${thread2}    Run Async    Chat_EP7337JFDK
    Comment    Wait Until    ${thread1}    ${thread2}
    sleep    60s
    Comment    ${openApp1}    Run Async
    Comment    ${openApp2}    Run Async

multithreads_Chat
    setServerCount    2
    addInstance    HQ51FYL18100    4020    4021    Android    4.4.2    com.remaller.android.wifitalkie_lite
    ...    com.remaller.talkie.core.CoreActivity
    addInstance    EP7337JFDK    4023    4024    Android    4.3    com.remaller.android.wifitalkie_lite
    ...    com.remaller.talkie.core.CoreActivity
    startServers    true
    sleep    10s
    ${thread1}=    Run Keyword Async    Chat_HQ51FYL18100
    ${thread2}=    Run Keyword Async    Chat_EP7337JFDK
    ${END}=    Wait Async All
    Comment    ${thread1}    Run Async    Chat_HQ51FYL18100
    Comment    ${thread2}    Run Async    Chat_EP7337JFDK
    Comment    Wait Until    ${thread1}    ${thread2}

singlethread
    [Documentation]    WifiTalkie chat test using robotFramework-appium-lib only
    setServerCount    2
    addInstance    HQ51FYL18100    4020    4021    Android    4.4.2    com.remaller.android.wifitalkie_lite
    ...    com.remaller.talkie.core.CoreActivity
    addInstance    EP7337JFDK    4023    4024    Android    4.3    com.remaller.android.wifitalkie_lite
    ...    com.remaller.talkie.core.CoreActivity
    startServers    False
    sleep    10s
    ${appium1}=    Open Application    http://localhost:4020/wd/hub    alias=HQ51FYL18100    platformName=Android    platformVersion=4.4.2    deviceName=HQ51FYL18100
    ...    udid=HQ51FYL18100    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    ${appium2}=    Open Application    http://localhost:4023/wd/hub    alias=EP7337JFDK    platformName=Android    platformVersion=4.3    deviceName=EP7337JFDK
    ...    udid=EP7337JFDK    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    Open Application    http://localhost:4020/wd/hub    platformName=Android    platformVersion=4.4.2    deviceName=HQ51FYL18100    udid=HQ51FYL18100
    ...    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    Open Application    http://localhost:4023/wd/hub    platformName=Android    platformVersion=4.3    deviceName=EP7337JFDK    udid=EP7337JFDK
    ...    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    locate users
    Wait Until Page Contains Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    Click Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    Switch Application    HQ51FYL18100
    Comment    Wait Until Page Contains Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]//*[2]
    Click Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]//*[2]
    Comment    locate chat button
    Switch Application    EP7337JFDK
    Comment    Wait Until Page Contains Element    accessibility_id=com.remaller.android.wifitalkie_lite:id/button_messages
    Click Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[2]//*[2]
    Switch Application    ${appium1}
    Comment    Wait Until Page Contains Element    accessibility_id=com.remaller.android.wifitalkie_lite:id/button_messages
    Comment    Click Element    accessibility_id=com.remaller.android.wifitalkie_lite:id/button_messages
    Click Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[2]//*[2]
    sleep    1s
    Input Text    id=com.remaller.android.wifitalkie_lite:id/messageEditText    ${chat1}
    Click Element    id=com.remaller.android.wifitalkie_lite:id/sendMessageButton
    Switch Application    EP7337JFDK
    Wait Until Page Contains Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]
    Input Text    id=com.remaller.android.wifitalkie_lite:id/messageEditText    ${chat2}
    Click Element    id=com.remaller.android.wifitalkie_lite:id/sendMessageButton
    Comment    stopAppiumServers

PA_multithread
    setServerCount    2
    addInstance    HQ51FYL18100    4020    4021    Android    4.4.2    com.remaller.android.wifitalkie_lite
    ...    com.remaller.talkie.core.CoreActivity
    addInstance    EP7337JFDK    4023    4024    Android    4.3    com.remaller.android.wifitalkie_lite
    ...    com.remaller.talkie.core.CoreActivity
    startServers    true
    sleep    10s
    ${thread1}=    Run Keyword Async    PA_EP7337JFDK
    ${thread2}=    Run Keyword Async    PA_HQ51FYL18100
    ${END}=    Wait Async All
    Comment    ${thread1}    Run Async    Chat_HQ51FYL18100
    Comment    ${thread2}    Run Async    Chat_EP7337JFDK
    Comment    Wait Until    ${thread1}    ${thread2}

multithreads_SendFile
    setServerCount    2
    addInstance    HQ51FYL18100    4020    4021    Android    4.4.2    com.remaller.android.wifitalkie_lite
    ...    com.remaller.talkie.core.CoreActivity
    addInstance    EP7337JFDK    4023    4024    Android    4.3    com.remaller.android.wifitalkie_lite
    ...    com.remaller.talkie.core.CoreActivity
    startServers    true
    sleep    5s
    ${thread1}=    Run Keyword Async    SendFile_HQ51FYL18100
    ${thread2}=    Run Keyword Async    SendFile_EP7337JFDK
    ${END}=    Wait Async All
    Comment    ${thread1}    Run Async    SendFile_HQ51FYL18100
    Comment    ${thread2}    Run Async    SendFile_EP7337JFDK
    Comment    Wait Until    ${thread1}    ${thread2}

*** Keywords ***
Chat_EP7337JFDK
    log    EP7337JFDK building
    Comment    startServer    EP7337JFDK    4023    4024    4025
    Comment    sleep    5s
    Comment    ${EP7337JFDK}    Open Application    http://localhost:4023/wd/hub    platformName=Android    platformVersion=4.3    deviceName=EP7337JFDK
    ...    udid=EP7337JFDK    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    ${appium2}=    Open Application    http://localhost:4023/wd/hub    alias=EP7337JFDK    platformName=Android    platformVersion=4.3
    ...    deviceName=EP7337JFDK    udid=EP7337JFDK    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    sleep    10s
    Comment    Switch Application    ${EP7337JFDK}
    Comment    Wait Until Page Contains    HTC_D526h
    Comment    Click Text    HTC_D526h
    Comment    Wait Until Page Contains Element    0    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    Click Element    0    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    Comment    Click Text    Open chat
    Comment    Switch Application    ${EP7337JFDK}
    Comment    Wait Until Page Contains Element    0    accessibility_id=com.remaller.android.wifitalkie_lite:id/button_messages
    Click Element    0    accessibility_id=com.remaller.android.wifitalkie_lite:id/button_messages
    Comment    Switch Application    ${EP7337JFDK}
    Comment    Wait Until Page Contains Element    0    id=com.remaller.android.wifitalkie_lite:id/messageEditText
    Input Text    0    id=com.remaller.android.wifitalkie_lite:id/messageEditText    Hello
    Comment    Switch Application    ${EP7337JFDK}
    Comment    Wait Until Page Contains Element    0    id=com.remaller.android.wifitalkie_lite:id/sendMessageButton
    Click Element    0    id=com.remaller.android.wifitalkie_lite:id/sendMessageButton

Chat_HQ51FYL18100
    log    HQ51FYL18100 building
    Comment    startServer    HQ51FYL18100    4020    4021    4022
    Comment    sleep    5s
    Comment    ${HQ51FYL18100}=    Open Application    http://localhost:4020/wd/hub    platformName=Android    platformVersion=4.4.2    deviceName=HQ51FYL18100
    ...    udid=HQ51FYL18100    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    ${appium1}=    Open Application    http://localhost:4020/wd/hub    alias=HQ51FYL18100    platformName=Android    platformVersion=4.4.2
    ...    deviceName=HQ51FYL18100    udid=HQ51FYL18100    automationName=appium    appPackage=com.remaller.android.wifitalkie_lite    appActivity=com.remaller.talkie.core.CoreActivity
    Comment    sleep    10s
    Comment    Switch Application    ${HQ51FYL18100}
    Comment    Wait Until Page Contains    C6802
    Comment    Click Text    C6802
    Comment    Wait Until Page Contains Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    Comment    Click Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    Click Element    1    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]//*[2]
    Comment    Click Text    Open chat
    Comment    Switch Application    ${HQ51FYL18100}
    Comment    Wait Until Page Contains Element    1    accessibility_id=com.remaller.android.wifitalkie_lite:id/button_messages
    Click Element    accessibility_0id=com.remaller.android.wifitalkie_lite:id/button_messages    accessibility_id=com.remaller.android.wifitalkie_lite:id/button_messages
    Comment    Switch Application    ${HQ51FYL18100}
    Comment    Wait Until Page Contains Element    1    id=com.remaller.android.wifitalkie_lite:id/messageEditText
    Input Text    1    id=com.remaller.android.wifitalkie_lite:id/messageEditText    hi
    Comment    Switch Application    ${HQ51FYL18100}
    Comment    Wait Until Page Contains Element    1    id=com.remaller.android.wifitalkie_lite:id/sendMessageButton
    Click Element    1    id=com.remaller.android.wifitalkie_lite:id/sendMessageButton

PA_EP7337JFDK
    Comment    Wait Until Page Contains Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    sleep    5s
    click_element_by_xpath    1    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    sleep    3s
    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/button_files
    sleep    3s
    click_element_by_xpath    1    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[2]
    sleep    1s
    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/itemCheckBox
    sleep    1s
    click_element_by_id    1    com.remaller.android.wifitalkie_lite:id/bottomBarDoneButton
    sleep    3s
    stopAppiumServers

PA_HQ51FYL18100
    Comment    Wait Until Page Contains Element    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    sleep    5s
    click_element_by_xpath    0    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]
    sleep    3s
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/button_messages
    Comment    sleep    10s
    wait_until_page_contains_id    0    com.remaller.android.wifitalkie_lite:id/declineButton    10
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/declineButton
    stopAppiumServers

SendFile_EP7337JFDK
    log    EP7337JFDK building
    sleep    5s
    Click Element    1    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[3]
    Click Element    1    accessibility_id=com.remaller.android.wifitalkie_lite:id/button_files
    Click Element    1    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[2]
    Click Element    1    accessibility_id=com.remaller.android.wifitalkie_lite:id/itemCheckBox
    Click Element    1    accessibility_id=com.remaller.android.wifitalkie_lite:id/bottomBarDoneButton

SendFile_HQ51FYL18100
    log    HQ51FYL18100 building
    Click Element    0    xpath=//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]
    Click Element    0    id=com.remaller.android.wifitalkie_lite:id/button_messages
    Wait Until Page Contains Element    0    id=com.remaller.android.wifitalkie_lite:id/declineButton    10
    Click Element    0    id=com.remaller.android.wifitalkie_lite:id/declineButton

finds
    sleep    3s
    Comment    find_element_by_accessibility_id    0    com.remaller.android.wifitalkie_lite:id/acceptCheckBox
    Comment    find_element_by_id    0    com.remaller.android.wifitalkie_lite:id/acceptCheckBox
    Comment    find_element_by_xpath    0    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]
    find_element_by_id    0    com.remaller.android.wifitalkie_lite:id/deviceName
    find_element_by_xpath    0    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]

click_and_taps
    sleep    3s
    Comment    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/acceptCheckBox
    Comment    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/submitButton
    click_element_by_xpath    0    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[2]//*[1]//*[1]//*[1]//*[1]//*[2]
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/button_messages
    Comment    tap_coordinate    0    150    500    500
    Comment    click_element_by_accessibility_id    0    com.remaller.android.wifitalkie_lite:id/button_messages

text_input
    sleep    3s
    input_text_by_id    0    com.remaller.android.wifitalkie_lite:id/messageEditText    hello
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/sendMessageButton
    input_text_by_xpath    0    //*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[1]//*[3]    123
    click_element_by_id    0    com.remaller.android.wifitalkie_lite:id/sendMessageButton
