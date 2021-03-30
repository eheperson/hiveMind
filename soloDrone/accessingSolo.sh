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
