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
# import elementfinder
import AppiumInstance


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
        x = AppiumInstance.appiumInstance()
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
            self.serverList[x].stopAppiumServers()
            self.threadList[x].join()

    def setServerCount(self, count):
        self.serverCount = int(count)

###########FIND
    def find_element_by_accessibility_id(self, num, id):
        return  self.serverList[int(num)]._find_element_by_accessibility_id(id)

    def find_element_by_id(self, num, id):
        return  self.serverList[int(num)]._find_element_by_id(id)

    def find_element_by_xpath(self, num, xpath):
        return  self.serverList[int(num)]._find_element_by_xpath(xpath)

##########CLICK

    def click_element_by_accessibility_id(self, num, id):
        self.serverList[int(num)]._click_element_by_accessibility_id(id)

    def click_element_by_id(self, num, id):
        self.serverList[int(num)]._click_element_by_id(id)

    def click_element_by_xpath(self, num, xpath):
        self.serverList[int(num)]._click_element_by_xpath(xpath)

    def tap_coordinate(self, num, x, y, duration):
        self.serverList[int(num)]._tap_coordinate(x, y, duration)

##########TEXT
    def input_text_by_id(self, num, id, text):
        self.serverList[int(num)]._input_text_by_id(id, text)

    def input_text_by_xpath(self, num, xpath, text):
        self.serverList[int(num)]._input_text_by_xpath(xpath, text)

##########WAIT

    def wait_until_page_contains_accessibility_id(self, num, id, timeout=10):
        self.serverList[int(num)]._wait_until_page_contains_accessibility_id(id, timeout)

    def wait_until_page_contains_id(self, num, id, timeout=10):
        self.serverList[int(num)]._wait_until_page_contains_id(id, timeout)

    def wait_until_page_contains_xpath(self, num, xpath, timeout=10):
        self.serverList[int(num)]._wait_until_page_contains_xpath(xpath, timeout)

