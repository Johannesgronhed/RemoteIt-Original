# Import neccessary libraries
import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common import action_chains, keys
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.common import exceptions
from selenium.webdriver.chrome.options import Options

chromeOptions = Options()
# Kiosk mode = fullscreen, disable-infobars = not showing the address bar, user-data-dir = use the default profile for Chrome
chromeOptions.add_argument("--kiosk")
chromeOptions.add_argument("disable-infobars")
chromeOptions.add_argument("user-data-dir=/Users/netadmin/Library/Application Support/Google/Chrome/Default")
chromeDriver = "/usr/local/bin/chromedriver"
# assign the webdriver to variable
driver = webdriver.Chrome(chromeDriver, chrome_options=chromeOptions)

# While this is true
while True:
    # read from conf file and save the value i Line variable
    v1 = open("/Users/netadmin/showWebsites/confSites.txt")
    Line = v1.readlines()
    web = 0 # gives the variable web value 0
    try: # now try to for loop and make firefox read line by line from the conf file
        for test in Line:
            driver.get(Line[web])
            checkURL = driver.current_url
            if checkURL == "https://chartbeat.com/signin/?next=/labs/publishing/bigboard/sydsvenskan.se/":
                subprocess.Popen("osascript /usr/local/bin/logIn.scpt", shell=True, stdout=True)
            time.sleep(80)
            web = web + 1
    except Exception as e: # When the lines from the conf file is finished, then restart.
        web = 0
