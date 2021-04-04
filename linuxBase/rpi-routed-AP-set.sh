#
#                                          +- RPi -------+
#                                      +---+ 10.10.0.2   |          +- Laptop ----+
#                                      |   |     WLAN AP +-)))  (((-+ WLAN Client |
#                                      |   | 192.168.4.1 |          | 192.168.4.2 |
#                                      |   +-------------+          +-------------+
#                  +- Router ----+     |
#                  | Firewall    |     |   +- PC#2 ------+
# (Internet)---WAN-+ DHCP server +-LAN-+---+ 10.10.0.3   |
#                  |   10.10.0.1 |     |   +-------------+
#                  +-------------+     |
#                                      |   +- PC#1 ------+
#                                      +---+ 10.10.0.4   |
#                                          +-------------+
#
# reference : https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md
#
#############################################################################
# Access point software package install:
#############################################################################
sudo apt install hostapd
#
# Enable the wireless access point service and set it to start when your Raspberry Pi boots:
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
#
# In order to provide network management services (DNS, DHCP) to wireless clients, 
# the Raspberry Pi needs to have the dnsmasq software package installed:
sudo apt install dnsmasq
#
# Finally, install netfilter-persistent and its plugin iptables-persistent. 
# This utilty helps by saving firewall rules and restoring them when the Raspberry Pi boots:
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
#
####   ####   ####   ####   ####
## Software installation is complete.
####   ####   ####   ####   ####
#
#############################################################################
# Set up the network router
#############################################################################
#
# To configure the static IP address, edit the configuration file for dhcpcd with:
sudo nano /etc/dhcpcd.conf
#
# Go to the end of the file and add the following:
#
# interface wlan1
#     static ip_address=192.168.4.1/24
#     nohook wpa_supplicant
#
#############################################################################
# Enable routing and IP masquerading : 
#############################################################################
# This section configures the Raspberry Pi to let wireless 
# clients access computers on the main (Ethernet) network, 
# and from there the internet.
#
# !! If you wish to block wireless clients from accessing       !!!!!
# !! the Ethernet network and the internet, skip this section.  !!!!!
#
sudo nano /etc/sysctl.d/routed-ap.conf
#
# File contents: 
# # https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md
# # Enable IPv4 routing
# net.ipv4.ip_forward=1
#
#
# > The main router will see all outgoing traffic from wireless clients 
#   as coming from the Raspberry Pi, allowing communication with the 
#   internet.
# > The Raspberry Pi will receive all incoming traffic, substitute the 
#   IP addresses back, and forward traffic to the original wireless client.
#
# This process is configured by adding a single firewall rule in the Raspberry Pi:
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#
# Now save the current firewall rules for IPv4 (including the rule above) and 
# IPv6 to be loaded at boot by the netfilter-persistent service:
sudo netfilter-persistent save
#
# Filtering rules are saved to the directory /etc/iptables/. 
# If in the future you change the configuration of your firewall, 
# make sure to save the configuration before rebooting.
#
#############################################################################
# Configure the DHCP and DNS services for the wireless network
#############################################################################
#
# The DHCP and DNS services are provided by dnsmasq. 
# The default configuration file serves as a template 
# for all possible configuration options, whereas we only need a few. 
# It is easier to start from an empty file.
#
# Rename the default configuration file and edit a new one:
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo nano /etc/dnsmasq.conf
#
# Add the following to the file and save it:
#
# interface=wlan1 # Listening interface
# dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h
#                 # Pool of IP addresses served via DHCP
# domain=wlan     # Local wireless DNS domain
# address=/gw.wlan/192.168.4.1
#                 # Alias for this router
#
# The Raspberry Pi will deliver IP addresses between 192.168.4.2 and 192.168.4.20, 
# with a lease time of 24 hours, to wireless DHCP clients. 
# You should be able to reach the Raspberry Pi under the name gw.wlan from wireless clients.
#
#############################################################################
Ensure wireless operation
#############################################################################
# To ensure WiFi radio is not blocked on your Raspberry Pi, 
# execute the following command:
sudo rfkill unblock wlan
#
# This setting will be automatically restored at boot time. 
# We will define an appropriate country code in the access point 
# software configuration, next.
#
#############################################################################
# Configure the access point software
#############################################################################
# Create the hostapd configuration file, located at :
#       /etc/hostapd/hostapd.conf
#
# to add the various parameters for your new wireless network : 
sudo nano /etc/hostapd/hostapd.conf
#
#
# Add the information below to the configuration file :
#
# country_code=TR
# interface=wlan1
# ssid=hive
# hw_mode=g
# channel=7
# macaddr_acl=0
# auth_algs=1
# ignore_broadcast_ssid=0
# wpa=2
# wpa_passphrase=intelligence13
# wpa_key_mgmt=WPA-PSK
# wpa_pairwise=TKIP
# rsn_pairwise=CCMP
#
# To use the 5 GHz band, 
# you can change the operations mode from hw_mode=g to hw_mode=a. 
# Possible values for hw_mode are:
    # a = IEEE 802.11a (5 GHz) (Raspberry Pi 3B+ onwards)
    # b = IEEE 802.11b (2.4 GHz)
    # g = IEEE 802.11g (2.4 GHz)
#
#
#############################################################################
# Run your new wireless access point
#############################################################################
sudo systemctl reboot
#
#
#
#############################################################################
#
#If SSH is enabled on the Raspberry Pi, 
# it should be possible to connect to it from your 
# wireless client as follows, assuming the pi account 
# is present: ssh pi@192.168.4.1 or ssh pi@gw.wlan
#
#
#