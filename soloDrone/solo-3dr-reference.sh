#
############################################################################################################
# Accessing Solo ###########
############################################################################################################
# Solo can be accessed via WiFi. 
# When Solo and its Controller are booted, 
# the Controller creates a private network between the two devices. 
# Any computer or smartphone can connect to this network 
# and access these devices via their IP addresses.
#
# The network assigns particular addresses to the Controller and to Solo. 
# All other devices are assigned within a particular range:
#       10.1.1.1 — Controller
#       10.1.1.10 — Solo
#       10.1.1.100–10.1.1.255 — Computers, phones, or other devices on the network
#
# Using SSH :  (connection to solo wifi is required !!)
ssh root@10.1.1.10 # password : TjSDBkAu
#
############################################################################################################
# Solo - Cli installation  ###########
############################################################################################################
# The Solo CLI tool performs several tasks that are essential for development on Solo. 
# These include:
#   Enabling simultaneous WiFi access to Solo and the Internet
#   Resizing the root partition
#   Installing runit, pip, and smart packages
#   Providing access to the video stream
#   Updating the firmware on Solo and the Controller
#   Downloading logs
#
# Installing solo-cli
#   Solo CLI is a command line application you install to your PC. 
#   This application can control Solo and the Controller when connected to their WiFi network. 
#
#       You will need Python and pip installed in order to run this utility.
#
# First connect to a WiFi network with Internet access. Run this command on your PC:
pip install git+https://github.com/3drobotics/solo-cli
#
# then, connect to the solo-wifi
# sshing does not needed for these steps
solo
solo info
#
# Connecting Solo to the Internet :
#   The solo wifi command connects your Controller to your home WiFi network. 
#
#       The development PC still needs to connect to the Controller's WiFi network 
#       and access Solo and the Controller using their dedicated IP addresses (`10.1.1.1` and `10.1.1.10`). 
#       The Controller provides Internet access to the connected PC. 
#       This is useful if the PC normally uses Wifi to connect to your home network.
# run :
# 'solo wifi --name=<ssid> --password=<password>'
#
#           You may need to disconnect and reconnect your PC to Solo's WiFi network in order enable Internet access 
#           (you can verify the PC connection by opening up a web browser and accessing any web page).
#
# 
############################################################################################################
#install development repos via solo-cli  ###########
############################################################################################################
#       This section demonstrates how to install various development tools using Solo CLI. 
#       You must first connect to the Internet, as shown in the previous section.
#
# Install smart repositories
#       smart is the Solo package manager
#       To install the list of repositories needed by smart, run:
solo install-smart
#
# Install runit
#       To add the runit script daemon (used to create new services):
solo install-runit
#
# Install pip
#   To install pip directly on Solo:
solo install-pip
#
############################################################################################################
# Deploying/running DroneKit scripts on Solo
############################################################################################################
#
# Use the 'solo script pack' command to package a folder containing DroneKit-Python scripts 
# and any dependencies into an archive for deployment to Solo. 
# 
# !!!! The host computer must be connected to the Internet, 
# !!!! and the folder must contain a requirements.txt file listing the (PyPi) dependencies:
solo script pack
#
# If successful, the command will create an archive in the 'solo-script.tar.gz' in the current directory.
#
# Deploy this archive to Solo and run a specified script using the 'solo script run <scripname>' command. 
# The host computer must be connected to the Solo wifi network, and Solo must also be connected to the Internet. !!!!!!!!!!!!!!!!!
#
# For example, to deploy and run the helloworld example:
solo script run helloworld.py
#
### Downloading Logs #####################################################################################################
#   To download logs to your host computer:
solo logs download
# 
# Logs are downloaded from both solo and the controller, and copied into subdirectories ./drone and ./controller (respectively).
#
#
############################################################################################################
# Expanding the Root Partition
############################################################################################################
#
# Solo splits its available space between a "root" partition for code and a "logs" partition. 
# In production, the root partition on Solo is fairly small in order to maximize the space available for logs. 
# When installing many packages or code samples, you can quickly reach the limits of space on this partition.
#
# You can use the 'solo resize' option to expand the root partition from its default of 90Mb to ~600Mb.
#
#           Resizing the partition will delete and recreate your `/log` directory.          !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#           Ensure you have any important data backed up first!                             !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# To expand the root partition run:
solo resize
#
# You may have to physically reboot (power cycle) your drone after the script is complete. !!!
#
#           Resizing the partition may occasionally fail 
#           ([bug #5](https://github.com/3drobotics/solo-cli/issues/5)). 
#           You can see this by running `df -h` on Solo and seeing if the root partition is resized, 
#           or if there is no longer a `/log` partition. 
#
#           The solution is simply to re-run : 'solo resize'
#
#
############################################################################################################
# Installing Files and Code
############################################################################################################
#
## Uploading Files #####################################################################################################
#   'rsync' is the preferred tool for synchronizing code and files between your desktop and Solo. 
#   To copy a file from the local filesystem to Solo:
rsync -avz local/file/path/. root@10.1.1.10:/solo/path/.
#
## Installing Packages #####################################################################################################
#   Solo is an rpm based system. These packages can be managed by the Smart Package Manager (Smart), already installed on your Solo.
#
#   These are the requirements for setting up Smart to work with our package repositories.
#       > First, install the Solo CLI.
#       > Connect to the Internet via solo wifi. This will be needed to download the package lists.
#       > Run 'solo install-smart' to install and download the package repository list.
#   This command is only needed to be run once. From now on, Solo can download packages when an Internet connection is enabled.
#
#   When logged into Solo's terminal, you can explore some of the features of Smart:
#       'smart install <packagename>'  :   will download and install a package from the repository.
#       'smart search <text>'          :   will search for packages matching a given string.
#
############################################################################################################
# Working With Python
############################################################################################################
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Python 2.7 is used throughout our system and in many of our examples.       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   There are a few ways in which you can deploy Python code to Solo.           !!!!!!!!!!!!!!!!!!!!!!
# 
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Some Python libraries are "binary" dependencies. 
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Solo does not ship a compiler (by design) and so cannot install code that requires C extensions. 
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Trial and error is adequate to discovering which packages are usable.
#
#
### Installing Python packages using Smart #####################################################################################################
#   Some Python libraries are provided by Solo's internal package manager. 
#   For example, opencv can be installed via Smart, which provides its own Python library. After running:
smart install python-opencv
#
#   You can see its Python library is installed:
python -c "import cv2; print cv2.__version__"
#
### Installing packages directly with pip #####################################################################################################
#   You can install code directly from pip on Solo.
#
#   By default, using _pip_ installs or updates packages in the **global** Python environment. 
#   We recommend that instead you [install packages into an isolated environment](#installing-packages-using-the-solo-client).
#   Having installed Solo CLI on your PC, you can initialize pip to work on Solo by running:
#
# After SSHing into Solo, you can then install packages directly: ( be sure pip is installed in solo : 'solo install-pip')
pip install requests
#
# We also recommend that you install git, as this will be needed to get many of the examples:
smart install git
#
### Installing packages using the Solo client #####################################################################################################
#  The recommended way of working with Python and DroneKit-Python is to use the Solo CLI to package and run the script in a virtual environment.
#
# Solo uses many globally installed packages that may be out of date (in particular, [DroneKit](example-dronekit.html)), 
# but which cannot be updated without potentially affecting Solo's stability. 
# Using a virtual environment allows you to safely use any package you like.
#
# The CLI takes care of packaging all the scripts in your current folder:
solo script pack
# The command also packages any dependencies listed in the folder's 'requirements.txt' file. A minimal requirements.txt for a dronekit app will look like this:
#
#   dronekit>=2.0.0
#
# You can then transfer the package to Solo, install it, and run it using the command:
#                                                                                       solo script run yourscriptname.py
### Installing packages into a virtualenv #####################################################################################################
#
#   The solo client is the easiest way to bundle and run a Python app into a virtual environment. 
#   It is however possible to manually perform the same tasks using virtualenv.
#
# On Linux and Mac OS X, first install virtualenv on Solo using pip:
pip install virtualenv
#
# Next, create (or navigate to) the directory in which your Python code will be run. Run the following command:
virtualenv env
#
# This creates an environment in the local env/ directory. 
# To "activate" this environment, run this command:
source ./env/bin/activate
#
# You will notice your shell prompt changes to read (env)root@3dr_solo:
# indicating that you are working in a virtualenv.
#
# Now all commands you run from your shell, 
# including launching scripts and installing packages, 
# will only affect this local environment. 
# For example, you can now install a different version of dronekit without impacting the global version:
pip install dronekit
#
#
#!!!!! The instructions for Windows are similar. 
#!!!!! The advanced topic Python bundles shows this process in more detail.
#
#!!!!! The *Smart Package Manager* is written in Python. 
#!!!!! While you are working in a *virtualenv*, 
#!!!!! you will notice that *Smart* no longer works! 
#!!!!! Run `deactivate` at any time to leave the environment.