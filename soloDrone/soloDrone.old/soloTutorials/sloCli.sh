#!/bin/bash
#
# "solo" Command Line Tool
#
# Installing Solo CLI

# Solo CLI is a command line application you install to your PC. 
# This application can control Solo and the Controller when connected to their WiFi network. 
# (You will need Python and pip installed in order to run this utility. )
#
# first steep (on computer command line)
pip install git+https://github.com/3drobotics/solo-cli
#
# To update :
pip install -U git+https://github.com/3drobotics/solo-cli 
#
# After installation (to check if installation is succeed) :
solo
# 
# if specofoc informations neededabout cmmands :
#	https://github.com/3drobotics/solo-cli
#
##################################################################################################
# Secton - 2
#
# Connecting Solo to the Internet
#	The 'solo wifi' command connects your Controller to your home WiFi network. 
#	Solo uses this connection (via the Controller network) to access the Internet during 
#	development and to download and install packages.
#
# 	The development PC still needs to connect to the Controller's WiFi network and access 
#	Solo and the Controller using their dedicated IP addresses (`10.1.1.1` and `10.1.1.10`). 
#	The Controller provides Internet access to the connected PC. This is useful if the 
#	PC normally uses Wifi to connect to your home network.
#
#
#		1- Connect your PC to the Controller's WiFi network.
#    		2- Run the following command from your PC's command line:
#
#			solo wifi --name=<ssid> --password=<password>
#			(The SSID and password should be those of a local WiFi network)
#		! You will (for now) need to run this command each time the Controller is reset. 
##################################################################################################
# Section -3
#	This section demonstrates how to install various development tools using Solo CLI. 
# 	(required internet connection)
#
# Instal 'smart' :
# 	smart is the Solo package manager 
solo install-smart
#
# Install 'runit' :
#	To add the runit script daemon (used to create new services):
solo install-runit
#
# Install 'pip' :
Install pip
#
###############################################################################################
# Deploying/running DroneKit scripts on Solo
#
#Use the 'solo script pack' command to package a folder containing DroneKit-Python scripts 
#and any dependencies into an archive for deployment to Solo. 
#The host computer must be connected to the Internet, and 
#the folder must contain a requirements.txt file listing the (PyPi) dependencies:

solo script pack

If successful, the command will create an archive in the solo-script.tar.gz in the current directory.

Deploy this archive to Solo and run a specified script using the solo script run <scripname> command. The host computer must be connected to the Solo wifi network, and Solo must also be connected to the Internet.

For example, to deploy and run the helloworld example:

solo script run helloworld.py

Downloading Logs

To download logs to your host computer:

solo logs download

Logs are downloaded from both solo and the controller, and copied into subdirectories ./drone and ./controller (respectively).
Expanding the Root Partition

Solo splits its available space between a "root" partition for code and a "logs" partition. In production, the root partition on Solo is fairly small in order to maximize the space available for logs. When installing many packages or code samples, you can quickly reach the limits of space on this partition.

You can use the solo resize option to expand the root partition from its default of 90Mb to ~600Mb.
Resizing the partition will delete and recreate your `/log` directory. Ensure you have any important data backed up first!

To expand the root partition run:

solo resize

You may have to physically reboot (power cycle) your drone after the script is complete.
Resizing the partition may occasionally fail ([bug #5](https://github.com/3drobotics/solo-cli/issues/5)). You can see this by running `df -h` on Solo and seeing if the root partition is resized, or if there is no longer a `/log` partition. The solution is simply to re-run `solo resize`. 
