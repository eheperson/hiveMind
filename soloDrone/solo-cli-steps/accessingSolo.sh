#
# Solo can be accessed via WiFi. 
# When Solo and its Controller are booted, 
# the Controller creates a private network between the two devices. 
# Any computer or smartphone can connect to this network and 
# access these devices via their IP addresses.
#
# When connected to the SoloLink wifi network (SoloLink-xxx) 
# created by the 3DR Solo Controller and Quadcopter 
# you are able to find the following addresses:
#   10.1.1.1 — Controller
#   10.1.1.10 — Solo
#   10.1.1.100–10.1.1.255 — Computers, phones, or other devices on the network
#
# connect to Solo's WiFi network 
# On Windows, 3drrobotics team recommend PuTTY or Cygwin with OpenSSH.
ssh root@10.1.1.10  #password:  TjSDBkAu
#
###############################################################################
######################## connect Solo to Wifi #################################
###############################################################################
#
# Connecting the solo to a common network or network with internet.
#
# We installed the Solo CLI, we now have more control over the solo network.
#
#
# In order to connect the solo to another network, 
# ensure that you are still connected to the existing solo network (SoloLink-xxx) !!!!!!!!!!!!!!!!!!!!
# and run the following code 
# replacing <ssid> with your WAP SSID and <password> with your WAP password:
# solo wifi --name=<ssid> --password=<password>
# 
# example :
#           solo wifi --name=solocommand --password=commandsolo