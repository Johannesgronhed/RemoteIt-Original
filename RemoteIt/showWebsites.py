import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common import action_chains, keys
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.common import exceptions

driver = webdriver.Firefox()
driver.maximize_window()



while True:
    v1 = open("showWebsites/confSites.txt")
    Line = v1.readlines()
    web = 0
    try:
	for test in Line:
	    driver.get(Line[web])
	    driver.refresh()
	    time.sleep(20)
	    web = web + 1
    except Exception as e:
	web = 0
   	   			  
