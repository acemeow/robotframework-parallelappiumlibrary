import unittest
from appium import webdriver
from subprocess import call
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from time import sleep
from selenium.webdriver.support.wait import WebDriverWait
import os, re, logging, subprocess, threading, socket, time, sys, thread

from AppiumLibrarySrc import AppiumLibrary
from AppiumLibrarySrc.keywords import *
from AppiumLibrarySrc.version import VERSION

class ParalleAppiumLib():

    ROBOT_LIBRARY_SCOPE = "GLOBAL"
    serverCount = int(2)
    serverList = []
    threadList = []


    # 1 setServerCount(count)
    # 2 addServer (serverNum, deviceName, packageName, activityName) **each server a tine
    # 3 startServers

    def addInstance(self, deviceName, appiumPort, bootstrapPort, platformName, platformVersion, packageName,
                    activityName):
        x = appiumInstance()
        x.setDeviceName(deviceName)
        x.setPort(appiumPort)
        x.setBoostrapPort(bootstrapPort)
        x.setAppPackage(packageName)
        x.setAppActivity(activityName)
        x.setPlatform(platformName)
        x.setVersion(platformVersion)
        self.serverList.append(x)
        self.threadList.append(None)
        return

    def startServers(self, withClient=False):
        self.serverList, self.serverCount
        for i in range(int(self.serverCount)):
            self.threadList[i] = threading.Thread(target=self.serverList[i].appiumInstance(withClient))
            self.threadList[i].start()
        j = int(0)
        while self.serverList[j] == None and j < self.serverCount:
            time.sleep(1)
            if self.serverList[j] != None:
                j += 1

        time.sleep(5)
        return

    def startClients(self):
        return

    def stopAppiumServers(self):
        for x in self.serverList:
            self.serverList[x].stopstopInstance()
            self.threadList[x].join()

    def setServerCount(self, count):
        self.serverCount = int(count)

    def click_element(self, num, locator):
        self.serverList[int(num)].clickElement(locator)

    def wait_until_page_contains_element(self, num, locator, timeout=None, error=None):
        self.serverList[int(num)].waitUntilPageContainsElement(locator, timeout, error)

    def input_text(self, num, locator, text):
        self.serverList[int(num)].inputText(locator, text)

    # def click_element(self, num, locator):
    #     self.serverList[int(num)].appiumLib.click_element(locator)
    #
    # def wait_until_page_contains_element(self, num, locator, timeout=None, error=None):
    #     self.serverList[int(num)].appiumLib.wait_until_page_contains_element(locator, timeout, error)
    #
    # def input_text(self, num, locator, text):
    #     self.serverList[int(num)].appiumLib.input_text(locator, text)

# ###########FIND
#     def PA_find_element_by_accessibility_id(self, num, id):
#         return  self.serverList[int(num)]._find_element_by_accessibility_id(id)
#
#     def PA_find_element_by_id(self, num, id):
#         return  self.serverList[int(num)]._find_element_by_id(id)
#
#     def PA_find_element_by_xpath(self, num, xpath):
#         return  self.serverList[int(num)]._find_element_by_xpath(xpath)
#
# ##########CLICK
#
#
#     def PA_click_element_by_accessibility_id(self, num, id):
#         self.serverList[int(num)]._find_element_by_accessibility_id(id).click()
#
#     def PA_click_element_by_id(self, num, id):
#         self.serverList[int(num)]._find_element_by_id(id).click()
#
#     def PA_click_element_by_xpath(self, num, xpath):
#         self.serverList[int(num)]._find_element_by_xpath(xpath).click()
#
#     def PA_tap_coordinate(self, num, x, y, duration):
#         self.serverList[int(num)]._tap_coordinate(x, y, duration)
#
# ##########TEXT
#     def PA_input_text_by_id(self, num, id, text):
#         self.serverList[int(num)]._input_text_by_id(id, text)
#
#     def PA_wait_until_page_contains_id(self, num, id, timeout):
#         self.serverList[int(num)]._wait_until_page_contains_id(id, timeout)



class appiumInstance(AppiumLibrary):
    deviceName = ""
    packageName = ""
    activityName = ""
    platformName = ""
    IPAddress = "127.0.0.1"
    appiumServiceUrl = ""
    platformVersion = ""

    appiumPort = ""
    bootstrapPort = ""
    chromedriverPort = ""
    # global appiumLib

    # def __init__(self):
    #     __version__ = VERSION
    #
    #     class AppiumLibrary(
    #         _LoggingKeywords,
    #         _RunOnFailureKeywords,
    #         _ElementKeywords,
    #         _ScreenshotKeywords,
    #         _ApplicationManagementKeywords,
    #         _WaitingKeywords,
    #         _TouchKeywords,
    #         _KeyeventKeywords,
    #         _AndroidUtilsKeywords,
    #     ):
    #
    #         ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    #         ROBOT_LIBRARY_VERSION = VERSION
    #
    #         def __init__(self, timeout=5, run_on_failure='Capture Page Screenshot'):
    #
    #             for base in AppiumLibrary.__bases__:
    #                 base.__init__(self)
    #             self.set_appium_timeout(timeout)
    #             self.register_keyword_to_run_on_failure(run_on_failure)



    def appiumInstance(self, withClient=None):
        # appiumLib = AppiumLibrary
        old_stdout = sys.stdout
        currentTime = time.strftime("%Y_%m_%d %H_%M_%S", time.localtime())
        file = open('../Test_log/' + self.deviceName + "_" + currentTime + ' appium.log', 'w+')
        sys.stdout = file
        log_path = os.path.abspath('../Test_log/' + self.deviceName + "_" + currentTime + ' appium.log')

        old_stdout = sys.stdout
        currentTime = time.strftime("%Y_%m_%d %H_%M_%S", time.localtime())
        if not os.path.exists(os.path.dirname('../Test_log/')):
            os.makedirs(os.path.dirname('../Test_log/'))

        # file = open('../Test_log/'+ self.deviceName +"_"+currentTime+' appium.log', 'w+')
        # sys.stdout = file
        # log_path = os.path.abspath('../Test_log/'+ self.deviceName +"_"+currentTime+' appium.log')
        args2 = "start /b appium -a {0} -p {1} -bp {2} -U {3}  --no-reset".format(self.IPAddress, self.appiumPort,
                                                                                  self.bootstrapPort, self.deviceName)
        p2 = subprocess.Popen(args2, stdout=open(log_path, 'a'), stderr=subprocess.PIPE, shell=True)
        try:
            p2.wait()
            time.sleep(5)
            print("[ParalleAppium] "u'devices:{} appium server started'.format(self.deviceName))

        except:
            print("[ParalleAppium] " + self.deviceName + " p2 start failed")
            print('')
        if(withClient):
            desired_caps = {}
            desired_caps['platformName'] = self.platformName
            desired_caps['platformVersion'] = self.platformVersion
            desired_caps['deviceName'] = self.deviceName
            desired_caps['appPackage'] = self.packageName
            desired_caps['appActivity'] = str(self.activityName)
            # appiumLib.open_application("http://127.0.0.1:" + self.appiumPort + "/wd/hub", **{'platformName' : self.platformName,
            #     'platformVersion':self.platformVersion,
            #     'deviceName':self.deviceName,
            #     'appPackage':self.packageName,
            #     'appActivity':str(self.activityName)})
            super(appiumInstance, self).open_application("http://localhost:" + self.appiumPort + "/wd/hub", **{'platformName' : self.platformName,
                'platformVersion':self.platformVersion,
                'deviceName':self.deviceName,
                'appPackage':self.packageName,
                'appActivity':str(self.activityName)})
            # self.driver = webdriver.Remote("http://localhost:" + self.appiumPort + "/wd/hub", desired_caps)

        sys.stdout = old_stdout

    # def clickElement(self, locator):
    #     appiumLib.click_element(locator)
    #
    # def waitUntilPageContainsElement(self, locator, timeout=None, error=None):
    #     appiumLib.wait_until_page_contains_element(locator, timeout, error)
    #
    # def inputText(self, locator, text):
    #     appiumLib.input_text(locator, text)

    def clickElement(self, locator):
        super(appiumInstance, self).click_element(locator)

    def waitUntilPageContainsElement(self, locator, timeout=None, error=None):
        super(appiumInstance, self).wait_until_page_contains_element(locator, timeout, error)

    def inputText(self, locator, text):
        super(appiumInstance, self).input_text(locator, text)


#     ###########FIND
#     def _find_element_by_accessibility_id(self, id):
#         return self.driver.find_element_by_accessibility_id(id)
#
#     def _find_element_by_id(self, id):
#         return self.driver.find_element_by_id(id)
#
#     def _find_element_by_xpath(self, xpath):
#         return self.driver.find_element_by_xpath(xpath)
#
# ##########CLICK
#     def _click_element_by_accessibility_id(self, id):
#         self.driver.find_element_by_accessibility_id(id).click()
#
#     def _click_element_by_id(self, id):
#         self.driver.find_element_by_id(id).click()
#
#     def _click_element_by_xpath(self, xpath):
#         self.driver.find_element_by_xpath(xpath).click()
#
#     def _tap_coordinate(self, x, y, duration):
#         self.driver.tap([x, y], duration)
#     ##########TEXT
#     def _input_text_by_id(self, id, texts):
#         try:
#             self._find_element_by_id(id).send_keys(texts)
#
#         except Exception as e:
#             raise e
#
#     ##########WAIT
#     def _wait_until_page_contains_id(self, id, timeout=None, error=None):
#         element = WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located((By.ID, id)))
#
#
#     ########################################################
    def stopInstance(self):
        self.driver.quit()
        return

    def getFreePort(self):
        s = socket.socket()
        s.bind(('', 0))  #
        return s.getsockname()[1]

    def setDeviceName(self, udid):
        self.deviceName = udid
        return

    def setAppPackage(self, packagename):
        self.packageName = packagename
        return

    def setAppActivity(self, activityname):
        self.activityName = activityname
        return

    def setPort(self, port):
        self.appiumPort = port
        return

    def setBoostrapPort(self, port):
        self.bootstrapPort = port

    def setPlatform(self, platform):
        self.platformName = platform

    def setVersion(self, ver):
        self.platformVersion = ver

    def stopAppiumServers(self):
        self.driver.quit()
        return
