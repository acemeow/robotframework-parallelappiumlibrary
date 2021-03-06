import os, re, logging, subprocess, threading, socket, time, sys, thread
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
                    activityName, browserName=None, xcodeOrgId=None, bundleID=None):
        x = AppiumInstance.appiumInstance()
        x.setDeviceName(deviceName)
        x.setPort(appiumPort)
        x.setBoostrapPort(bootstrapPort)
        x.setAppPackage(packageName)
        x.setAppActivity(activityName)
        x.setBrowserName(browserName)
        x.setPlatform(platformName)
        x.setVersion(platformVersion)
        x.setBundleId(bundleID)
        x.setXcodeOrgId(xcodeOrgId)
        x.setXcodeSigningId("iPhone developer")
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
            time.sleep(2)
            if self.serverList[j] != None:
                j += 1

        time.sleep(5)
        return

    def startClients(self):
        return

    def stopAppiumServers(self):
        for k in range(int(self.serverCount)):
            self.serverList[k].stopInstance()
            #self.threadList[k].join()
        os.system("killall node")

    def setServerCount(self, count):
        self.serverCount = int(count)

###########FIND
    def find_element_by_accessibility_id(self, num, id):
        return  self.serverList[int(num)]._find_element_by_accessibility_id(id)

    def find_element_by_id(self, num, id):
        return  self.serverList[int(num)]._find_element_by_id(id)

    def find_element_by_xpath(self, num, xpath):
        return  self.serverList[int(num)]._find_element_by_xpath(xpath)

    def find_element_by_class_name(self, num, className):
        return  self.serverList[int(num)]._find_element_by_class_name(className)

    def find_element_by_name(self, num, name):
        return self.serverList[int(num)]._find_element_by_name(name)

##########CLICK

    def click_element_by_accessibility_id(self, num, id):
        self.serverList[int(num)]._click_element_by_accessibility_id(id)

    def click_element_by_id(self, num, id):
        self.serverList[int(num)]._click_element_by_id(id)

    def click_element_by_xpath(self, num, xpath):
        self.serverList[int(num)]._click_element_by_xpath(xpath)

    def click_element_by_class_name(self, num, className):
        self.serverList[int(num)]._click_element_by_class_name(className)

    def click_element_by_name(self, num, name):
        self.serverList[int(num)]._click_element_by_name(name)

    def tap_coordinate(self, num, x, y, duration):
        self.serverList[int(num)]._tap_coordinate(x, y, duration)

    def swipe(self, num, x1, y1, x2, y2, duration):
        self.serverList[int(num)]._swipe(x1, y1, x2, y2, duration)

##########TEXT
    def input_text_by_id(self, num, id, text):
        self.serverList[int(num)]._input_text_by_id(id, text)

    def input_text_by_xpath(self, num, xpath, text):
        self.serverList[int(num)]._input_text_by_xpath(xpath, text)

    def input_text_by_class_name(self, num, className, text):
        self.serverList[int(num)]._input_text_by_class_name(className, text)

    def input_text_by_name(self, num, name, text):
        self.serverList[int(num)]._input_text_by_name(name, text)

##########WAIT

    def wait_until_page_contains_accessibility_id(self, num, id, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_accessibility_id(id, timeout)

    def wait_until_page_contains_id(self, num, id, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_id(id, timeout)

    def wait_until_page_contains_xpath(self, num, xpath, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_xpath(xpath, timeout)

    def wait_until_page_contains_class_name(self, num, className, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_class_name(className, timeout)

    def wait_until_page_contains_name(self, num, name, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_name(name, timeout)

    def goToURL(self, num, URL):
        self.serverList[int(num)]._goToURL(URL)

##########ASSERTS

    def asserts_page_contains_accessibility_id(self, num, id, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_accessibility_id(id, timeout)

    def asserts_page_contains_id(self, num, id, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_id(id, timeout)

    def asserts_page_contains_xpath(self, num, xpath, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_xpath(xpath, timeout)

    def asserts_page_contains_class_name(self, num, className, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_class_name(className, timeout)

    def asserts_page_contains_name(self, num, name, timeout=30):
        self.serverList[int(num)]._wait_until_page_contains_name(name, timeout)

##########OTHERS


    def hide_keyboard(self, num):
        self.serverList[int(num)]._hide_keyboard()

    def back(self, num):
        self.serverList[int(num)]._back()

# ios_webkit_debug_proxy -c 607dd2124bfe2b5f95929539bf41e68265009de7:27753 -d