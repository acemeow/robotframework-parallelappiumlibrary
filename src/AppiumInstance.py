import unittest
from appium import webdriver
from subprocess import call
# from selenium import webdriver
from selenium.webdriver.common.by import By
# from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from appium.webdriver.common.touch_action import TouchAction
from time import sleep
from selenium.webdriver.support.wait import WebDriverWait
import os, re, logging, subprocess, threading, socket, time, sys, thread
import platform
import signal


class appiumInstance():
    deviceName = None
    packageName = None
    activityName = None
    platformName = None
    browserName = None
    # for iOS
    bundleId = packageName
    xcodeOrgId = None
    xcodeSigningId = "iPhone Developer"

    IPAddress = "127.0.0.1"
    appiumServiceUrl = ""
    platformVersion = ""

    appiumPort = ""
    bootstrapPort = ""
    chromedriverPort = ""

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

        if (platform.system() == 'windows'):
            args2 = "start /b appium -a {0} -p {1} -bp {2} -U {3} --no-reset".format(self.IPAddress, self.appiumPort,
                                                                                     self.bootstrapPort,
                                                                                     self.deviceName)
        else:
            args2 = "node /usr/local/lib/node_modules/appium/build/lib/main.js -a {0} -p {1} -bp {2} -U {3} &".format(
                self.IPAddress, self.appiumPort, self.bootstrapPort, self.deviceName)
        global p2
        p2 = subprocess.Popen(args2, stdout=open(log_path, 'a'), stderr=subprocess.PIPE, shell=True)

        try:
            p2.wait()
            time.sleep(20)
            print("[ParalleAppium] "u'devices:{} appium server started'.format(self.deviceName))

        except:
            print("[ParalleAppium] " + self.deviceName + " p2 start failed")
            print('')
        if (withClient):
            self.bundleId = self.packageName
            desired_caps = {}
            desired_caps['platformName'] = self.platformName
            desired_caps['platformVersion'] = self.platformVersion
            desired_caps['deviceName'] = self.deviceName
            # desired_caps['useNewWDA'] = "true"
            # desired_caps['showXcodeLog'] = "true"
            desired_caps['resetOnSessionStartOnly'] = "true"
            desired_caps['newCommandTimeout'] = 300
            if (self.browserName != None):
                desired_caps['browserName'] = self.browserName
            if (self.bundleId != None):
                desired_caps['bundleId'] = self.bundleId
                desired_caps['useNewWDA'] = "true"
                desired_caps['useJSONSource'] = "true"
                # desired_caps['updatedWDABundleId'] = "com.Acetesting.WDA"
                desired_caps['showXcodeLog'] = "true"
                desired_caps['clearSystemFiles'] = "true"
            if (self.packageName != None):
                desired_caps['appPackage'] = self.packageName
                #desired_caps['waitForQuiescence'] = "false"
            if (self.activityName != None):
                desired_caps['appActivity'] = str(self.activityName)
            if (self.xcodeOrgId != None):
                desired_caps['xcodeOrgId'] = self.xcodeOrgId
                desired_caps['startIWDP'] = "true"
                desired_caps['automationName'] = "XCUITest"
            if (self.xcodeSigningId != None):
                desired_caps['xcodeSigningId'] = self.xcodeSigningId
            self.driver = webdriver.Remote("http://127.0.0.1:" + self.appiumPort + "/wd/hub", desired_caps)
            # self.driver = webdriver.Remote("http://localhost:" + self.appiumPort + "/wd/hub", desired_caps)
        sys.stdout = old_stdout

    def stopInstance(self):
        self.driver.quit()
        # self.closeApp()
        # os.system("killall node")
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

    def setBrowserName(self, browserName):
        self.browserName = browserName
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

    def setBundleId(self, bundleID):
        self.bundleId = bundleID

    def setXcodeOrgId(self, xcodeOrgID):
        self.xcodeOrgId = xcodeOrgID

    def setXcodeSigningId(self, xcodeSigningID):
        self.xcodeSigningId = xcodeSigningID

    def stopAppiumServers(self):
        # self.driver.close_app()
        self.driver.quit()
        return

    ########### FIND #####################################################
    def _find_element_by_accessibility_id(self, id):
        self.driver.find_element_by_accessibility_id(id)

    def _find_element_by_id(self, id):
        self.driver.find_element_by_id(id)

    def _find_element_by_xpath(self, xpath):
        self.driver.find_element_by_xpath(xpath)

    def _find_element_by_class_name(self, className):
        self.driver.find_element_by_class_name(className)

    def _find_element_by_name(self, name):
        self.driver.find_element_by_name(name)
        # self.driver.find_element_by_link_text()
        # self.driver.find_element_by_tag_name()
        # self.driver.scroll()

    ########## CLICK #####################################################
    def _click_element_by_accessibility_id(self, id):
        self.driver.find_element_by_accessibility_id(id).click()

    def _click_element_by_id(self, id):
        self.driver.find_element_by_id(id).click()

    def _click_element_by_xpath(self, xpath):
        self.driver.find_element_by_xpath(xpath).click()

    def _click_element_by_class_name(self, className):
        self.driver.find_element_by_class_name(className)

    def _click_element_by_name(self, name):
        self.driver.find_element_by_name(name)

    def _tap_coordinate(self, x, y, duration):
        # self.driver.tap([x, y], duration)
        TouchAction(self.driver).tap(None, x, y, 1).perform()
        # TouchAction(self.driver).tap(x, y).perform()

    def _swipe(self, x1, y1, x2, y2, duration):
        self.driver.swipe(x1, y1, x2, y2, duration)

    ########## TEXT #####################################################

    def _input_text_by_accessibility_id(self, accessibility_id, texts):
        try:
            self.driver.find_element_by_accessibility_id(accessibility_id).send_keys(texts)
        except Exception as e:
            raise e

    def _input_text_by_id(self, id, texts):
        try:
            self.driver.find_element_by_id(id).send_keys(texts)
        except Exception as e:
            raise e

    def _input_text_by_xpath(self, xpath, texts):
        try:
            self.driver.find_element_by_xpath(xpath).send_keys(texts)
        except Exception as e:
            raise e

    def _input_text_by_class_name(self, className, texts):
        try:
            self.driver.find_element_by_class_name(className).send_keys(texts)
        except Exception as e:
            raise e

    def _input_text_by_name(self, name, texts):
        try:
            self.driver.find_element_by_name(name).send_keys(texts)
        except Exception as e:
            raise e

    ########## WAIT #####################################################
    def _wait_until_page_contains_accessibility_id(self, id, timeout, error=None):
        WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located((By.ID, id)))

    def _wait_until_page_contains_id(self, name, timeout, error=None):
        WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located((By.NAME, name)))

    def _wait_until_page_contains_xpath(self, xpath, timeout, error=None):
        WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located((By.XPATH, xpath)))

    def _wait_until_page_contains_class_name(self, className, timeout, error=None):
        WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located((By.CLASS_NAME, className)))

    def _wait_until_page_contains_name(self, name, timeout, error=None):
        WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located((By.NAME, name)))

    def _goToURL(self, URL):
        self.driver.get(URL)

    ########## ASSERTS #####################################################
    def _element_should_be_disabled(self, locator, arg):
        return

    def _element_is_visible(self):
        return

    def _element_contain_text(self, locatorName, locator, text):
        if (locatorName == "accessibility_id"):
            if (self.driver.find_element_by_accessibility_id(locator).text==text):
                return True
        if (locatorName == "id"):
            if (self.driver.find_element_by_id(locator).text == text):
                return True
        if (locatorName == "xpath"):
            if (self.driver.find_element_by_xpath(locator).text==text):
                return True
        if (locatorName == "name"):
            if (self.driver.find_element_by_name(locator).text==text):
                return True
        return False

    def _element_text_should_be(self):
        return

    def _element_value_should_be(self):
        return

    def _page_contain_element(self, locatorName, locator):
        try:
            if (locatorName == "accessibility_id"):
                self.driver.find_element_by_accessibility_id(locator)
            if (locatorName == "id"):
                self.driver.find_element_by_id(locator)
            if (locatorName == "xpath"):
                self.driver.find_element_by_xpath(locator)
            if (locatorName == "name"):
                self.driver.find_element_by_name(locator)
        except:
            return False
        #return True

    def _page_not_contain_element(self, locatorName, locator):
        try:
            if (locatorName == "accessibility_id"):
                self.driver.find_element_by_accessibility_id(locator)
            if (locatorName == "id"):
                self.driver.find_element_by_id(locator)
            if (locatorName == "xpath"):
                self.driver.find_element_by_xpath(locator)
            if (locatorName == "name"):
                self.driver.find_element_by_name(locator)
        except:
            return True
        return False

    ##########OTHERS

    def _hide_keyboard(self):
            self.driver.hide_keyboard()

    def _back(self):
            self.driver.back()
