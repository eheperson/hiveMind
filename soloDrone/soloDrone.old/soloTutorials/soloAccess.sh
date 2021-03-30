#!/bin/bash
#
# Accesing Solo : 
#  1- Conenct to the solo wireless network
#  2- After conndection :
#	10.1.1.1 — Controller
#	10.1.1.10 — Solo
#   - We will use SSH protocol to connect  solo-cli
ssh root@10.1.1.10 # passwd : TjSDBkAu
#
# Your SSH client will then have direct terminal access to Solo.
#
# SECURITY : 
# Solo's root SSH password is the same for all devices. 
# We recommend not modifying the SSH password. Instead, 
# improve security on your device by changing the WiFi SSID and 
# password via the app.

