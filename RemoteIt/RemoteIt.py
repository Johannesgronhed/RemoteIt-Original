# RemoteIt is a program built with Python2.7 and is used to send configuration files and remote control
# small Compute Sticks.
# Made by Alexander Andersson (2016-11-18)
#
#
## Imports different kinds of Libraries for use of both showing websites
## and write files to the operating system.

import subprocess
import time
import os
from Tkinter import *
import io

# function to add a computer in the program
def addComputer():
    global uName, uIp, windowAdd #global variables
    computeName = uName.get() # get the information from uName variable and store it in computeName
    computeIp = uIp.get() # get the information from uIp variable and store it in computeIp

    # Write the information from computeName and computeIp to a file called addressesCompute.txt
    with io.FileIO("/etc/RemoteIt/addressesCompute.txt", "a") as file:
        file.write(computeName + '\t' + computeIp + "\n")
        file.close()
        quit()

# function to connect and remote control a compute stick
def Connection():
    global connect # global variable
    thisConnect = connect.get() # get the information from connect and store it in thisConnect
    TunnelIT = "ssh -L 5901:127.0.0.1:5901 -N -n -f -l netadmin ${0} ", thisConnect # well, variable to open up ssh port connection local
    ScreenIT = "open vnc://netadmin@${0}:5901", thisConnect # open up OS X Built-in program vnc

    subprocess.call(TunnelIT, stdout=True, shell=True) # call for the variable TunnelIt and open up connection
    subprocess.Popen(ScreenIT, stdout=True, shell=True) # Conenct with Built-in vnc program

# function to send configuration
def sendConf():
    global l1, l2, l3, l4, l5, windowConf # global variables
    # get the information and store it in those variables
    firstWeb = l1.get()
    seconWeb = l2.get()
    thirdWeb = l3.get()
    fourthWeb = l4.get()
    ip = l5.get()

    # write the information that is stored in the variables and save it down to confSites.txt
    with io.FileIO("/etc/RemoteIt/confSites.txt", "w") as file:
        file.write(firstWeb + "\n")
        file.write(seconWeb + "\n")
        file.write(thirdWeb + "\n")
        file.write(fourthWeb + "\n")
        file.close()

    time.sleep(10) # wait in case the file write isn't done yet

    # send the configuration to the computer
    sendConfIT = "scp /etc/RemoteIt/confSites.txt netadmin@${0}:/home/netadmin/showWebsites/", ip
    subprocess.call(sendConfIT, stdout=True, shell=True )
    windowConf.destroy() # close the window when done

# function to show GUI for the sendConf function
def sendIT():

    global l1, l2, l3, l4, l5, windowConf
    windowConf = Tk()
    windowConf.title("Send it!")
    windowConf.wm_attributes("-topmost", 1)
    windowConf.focus_force()
    t1 = Label(windowConf, text="1. Website: ", width=30)
    t1.pack()
    l1 = Entry(windowConf)
    l1.insert(END, "http://")
    l1.pack()
    t2 = Label(windowConf, text="2. Website: ")
    t2.pack()
    l2 = Entry(windowConf)
    l2.insert(END, "http://")
    l2.pack()
    t3 = Label(windowConf, text="3. Website: ")
    t3.pack()
    l3 = Entry(windowConf)
    l3.insert(END, "http://")
    l3.pack()
    t4 = Label(windowConf, text="4. Website: ")
    t4.pack()
    l4 = Entry(windowConf)
    l4.insert(END, "http://")
    l4.pack()
    t5 = Label(windowConf, text="Which computer? (IP): ")
    t5.pack()
    l5 = Entry(windowConf)
    l5.pack()
    btnClick = Button(windowConf, text="Send!", command=sendConf)
    btnClick.pack()

# function to show GUI for adding a computer
def add():
    global uName, uIp, windowAdd, top
    windowAdd = Tk()
    windowAdd.title("Add Computer")
    windowAdd.wm_attributes("-topmost", 1)
    windowAdd.focus_force()
    t1 = Label(windowAdd, text="Type in name for stick: ", width=30)
    t1.pack()
    uName = Entry(windowAdd)
    uName.pack()
    t2 = Label(windowAdd, text="Type in Ip: ")
    t2.pack()
    uIp = Entry(windowAdd)
    uIp.pack()

    btn1 = Button(windowAdd, text="Add!", command=addComputer)
    btn1.pack()

# function to quit the window
def quit():
    global  windowAdd
    windowAdd.destroy()

# function to exit the program
def exit():
    sys.exit(0)

# function for the Main start of the program
def mainStart():
    global top, label, connect

    # check if the path exists, otherwise create it.
    if os.path.exists("/etc/RemoteIt"):
        print "nothing"
    else:
        subprocess.call("mkdir -p /etc/RemoteIt", shell=True, stdout=True)
        subprocess.call("touch /etc/RemoteIt/addressesCompute.txt", shell=True, stdout=True)

    confFile = "/etc/RemoteIt/addressesCompute.txt" # variable to show the compute sticks that has been added.

    computersFile = open(confFile)
    line = computersFile.read()
    computersV = line
    mainWindow = Tk()
    mainWindow.title("Remote It!")
    mainWindow.wm_attributes("-topmost", 1)
    mainWindow.focus_force()
    mainWindow.resizable(width=False, height=False)
    mainWindow.geometry('{}x{}'.format(450, 200))
    top = Frame(mainWindow)

    top = Label(mainWindow, text=computersV)
    top.pack(side=TOP)

    bottom = Frame(mainWindow)
    bottom.pack(side=BOTTOM)
    ipLabel = Label(mainWindow, text="IP:").place(y=140, x=115)
    connect = Entry(mainWindow, width=10)
    connect.place(y=140, x=140)
    connectBtn = Button(mainWindow, text="Connect", command=Connection)
    connectBtn.place(y=140, x=250)

    btn1 = Button(mainWindow, text="Add Computer", command=add)
    btn2 = Button(mainWindow, text="Create Configuration", command=sendIT)
    btn3 = Button(mainWindow, text="Exit", command=exit)
    btn1.pack(in_=bottom, side=LEFT)
    btn2.pack(in_=bottom, side=LEFT)
    btn3.pack(in_=bottom, side=LEFT)

    mainWindow.mainloop()

mainStart() # Run the program.
