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
import elementfinder

class appiumInstance():
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
            self.driver = webdriver.Remote("http://127.0.0.1:" + self.appiumPort + "/wd/hub", desired_caps)

        sys.stdout = old_stdout

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


    ########### FIND #####################################################
    def _find_element_by_accessibility_id(self, id):
        self.driver.find_element_by_accessibility_id(id)

    def _find_element_by_id(self, id):
        self.driver.find_element_by_id(id)

    def _find_element_by_xpath(self, xpath):
        self.driver.find_element_by_xpath(xpath)
        # self.driver.find_element_by_class_name()
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

    def _tap_coordinate(self, x, y, duration):
        self.driver.tap([x, y], duration)

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


    ########## WAIT #####################################################
    def _wait_until_page_contains_accessibility_id(self, id, timeout=100, error=None):
        return WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located((By.ID, id)))

    def _wait_until_page_contains_id(self, name, timeout=100, error=None):
        return WebDriverWait(self.driver, 10).until(EC.presence_of_element_located((By.NAME, name)))

    def _wait_until_page_contains_xpath(self, xpath, timeout=100, error=None):
        return WebDriverWait(self.driver, timeout).until(EC.presence_of_element_located((By.XPATH, xpath)))

    ########## ASSERTS #####################################################
    def _element_should_be_disabled(self, locator, arg):
        return
    def _element_should_be(self):
        return
    def _element_should_be_visible(self):
        return
    def _element_should_contain_text(self):
        return
    def _element_should_not_contain_text(self):
        return
    def _element_text_should_be(self):
        return
    def _element_value_should_be(self):
        return
    def _page_should_contain_element(self):
        return
    def _page_should_not_contain_element(self):
        return
    def _page_should_contain_text(self):
        return
    def _page_should_not_contain_text(self):
        return

