#----------------------------------------------------------------------------------------
# Find The Name of Your Wireless Interface And Wireless Network --------------
#----------------------------------------------------------------------------------------
# list connected network adapters :
iwconfig
#
# Scan for available wifi connection for selected network device : 
sudo iwlist wlan0 scan | grep ESSID
# try if fails : sudo iwlist wlp4s0 scan | grep ESSID
#
#----------------------------------------------------------------------------------------
# Connect to Wi-Fi Network With WPA_Supplicant --------------
#----------------------------------------------------------------------------------------
# Install wpasupplicant from default software repository (no Internet required)
sudo apt install wpasupplicant
#
# Store wifi name (ESSID) and password into /etc/wpa_supplicant.conf.
# wpa_passphrase WIFI_ESSID_NAME WIFI_PASSWORD | sudo tee /etc/wpa_supplicant.conf
wpa_passphrase "hive" "intelligence13" | sudo tee /etc/wpa_supplicant.conf
#
# Connect to wifi
sudo wpa_supplicant -c /etc/wpa_supplicant.conf -i wlan0
#
#********************************************************************************************
# The connection might fail with CTRL-EVENT-DISCONNECTED 
# You might need to disable NetworkManager
sudo systemctl stop NetworkManager
# Optional to disable NetworkManager to auto-start during bootup :
sudo systemctl disable NetworkManager-wait-online NetworkManager-dispatcher NetworkManager
#Try again. Should see CTRL-EVENT-CONNECTED upon success : 
sudo wpa_supplicant -c /etc/wpa_supplicant.conf -i wlan0
#********************************************************************************************
#
# wpa_supplicant run in the foreground by default, press CTRL-C to stop it.
# Now run wpa_supplicant in the background.
# we could run it in the background by adding the -B flag.
sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlan0
#
# Get IP address via DHCP
sudo dhclient wlan0
# output should be like : cmp: EOF on /tmp/tmp.ZAVph8f1KE which is empty
# NOTE: To relase ip address 'sudo dhclient wlan0 -r'
#
# Show IP address
ip addr show wlan0
#
# Test if Internet is accessible
ping 8.8.8.8
#
#********************************************************************************************
# **** Connecting to Hidden Wireless Network
#
# If your wireless router doesn’t broadcast ESSID, then you need to add the following line in /etc/wpa_supplicant.conf file.
#
        # scan_ssid=1
        # Like below:
        # #
        # network={
        #         ssid="LinuxBabe.Com Network"
        #         #psk="12345qwert"
        #         psk=68add4c5fee7dc3d0dac810f89b805d6d147c01e281f07f475a3e0195
        #         scan_ssid=1
        # }
#********************************************************************************************
#
#----------------------------------------------------------------------------------------
# Connect to Wi-Fi Network With WPA_Supplicant --------------
#----------------------------------------------------------------------------------------
# To automatically connect to wireless network at boot time, we need to edit the 'wpa_supplicant.service' file.
# It could be a good idea to copy the file from '/lib/systemd/system/' directory to '/etc/systemd/system/' directory, 
# then edit the file content.
# Because we don’t want a newer version of wpa_supplicant to override our modifications.
#
# copy the file from '/lib/systemd/system/' directory to '/etc/systemd/system/' directory
sudo cp /lib/systemd/system/wpa_supplicant.service /etc/systemd/system/wpa_supplicant.service
#
# Edit the file with a command-line text editor, such as Nano.
sudo nano /etc/systemd/system/wpa_supplicant.service
#
        # Find the following line.
        #     ExecStart=/sbin/wpa_supplicant -u -s -O /run/wpa_supplicant
        # #
        # Change it to the following. 
        # Here we added the configuration file and the wireless interface name to the ExecStart command.
        #     ExecStart=/sbin/wpa_supplicant -u -s -c /etc/wpa_supplicant.conf -i wlan0
        # #
        # It’s recommended to always try to restart wpa_supplicant when failure is detected. Add the following right below the ExecStart line.
        #     Restart=always
        # #
        # If you can find the following line in this file, comment it out (Add the # character at the beginning of the line).
        #     Alias=dbus-fi.w1.wpa_supplicant1.service
        # #
        # Save and close the file. (To save a file in Nano text editor, press Ctrl+O, then press Enter to confirm. To exit, press Ctrl+X.)
#
# Then reload systemd.
sudo systemctl daemon-reload
#
# Enable wpa_supplicant service to start at boot time.
sudo systemctl enable wpa_supplicant.service
#
# We also need to start 'dhclient' at boot time to obtain a private IP address from DHCP server. 
# This can be achieved by creating a systemd service unit for 'dhclient'.
sudo nano /etc/systemd/system/dhclient.service
#
        # Put the following text into the file.
        #     [Unit]
        #     Description= DHCP Client
        #     Before=network.target
        #     After=wpa_supplicant.service

        #     [Service]
        #     Type=forking
        #     ExecStart=/sbin/dhclient wlan0 -v
        #     ExecStop=/sbin/dhclient wlan0 -r
        #     Restart=always
            
        #     [Install]
        #     WantedBy=multi-user.target
#
# Save and close the file. Then enable this service.
sudo systemctl enable dhclient.service
#
#
#----------------------------------------------------------------------------------------
# How to Obtain a Static IP Address --------------
#----------------------------------------------------------------------------------------
# If you want to obtain a static IP address, then you need to disable 'dhclient.service'.
sudo systemctl disable dhclient.service
#
# We need to use netplan to configure static IP address on Ubuntu 18.04/20.04. 
# Create a configuration file under '/etc/netplan/''.
sudo nano /etc/netplan/10-wifi.yaml
#
# Add the following lines to this file. 
# Replace 'xxx.xxx.xxx.xxx' with your preferred IP address. 
# Please be careful about the indentation. An extra space would make the configuration invalid.
# 192.168.4.1 is the raspberry pi adress
        # network:
        #     ethernets:
        #         wlp4s0:
        #             dhcp4: no
        #             addresses: [xxx.xxx.xxx.xxx/24]
        #             gateway4: 192.168.4.1
        #     version: 2
#
# Save and close the file. Then apply the configurations.
sudo netplan apply
#
# You can also turn on the --debug option if it doesn’t work as expected.
        # sudo netplan --debug apply
#
# If there are other ''.yaml' files under '/etc/netplan/'' directory, 
# then netplan will automatically merge configurations from different files. 
# 'netplan' uses 'systemd-networkd' as the backend network renderer. 
# It’s recommended to configure the 'wpa_supplicant.service' runs before 'systemd-networkd.service', 
# so the system will first associate with a Wi-Fi access point, then obtain a private IP address.
sudo nano /etc/systemd/system/wpa_supplicant.service
#Find the following line.
    # Before=network.target
#Change it to:
    # Before=network.target systemd-networkd.service
#Save and close the file.
#
#********************************************************************************************
# Another way to obtain a static IP address is by logging into your router’s management interface 
# and assigning a static IP to the MAC address of your wireless card, if your router supports this feature.
#********************************************************************************************
#
#----------------------------------------------------------------------------------------
# Using a Hostname to Access Services on Ubuntu --------------
#----------------------------------------------------------------------------------------
# Actually, you don’t have to obtain a static IP address for your Ubuntu box. 
# Ubuntu can use 'mDNS (Multicast DNS)'' to announce its hostname to the local network and 
# clients can access services on your Ubuntu box with that hostname. 
# This hostname can always be resolved to the IP address of your Ubuntu box, even if the IP address changes.
#
# In order to use 'mDNS', you need to install 'avahi-daemon', which is an open-source implementation of 'mDNS/DNS-SD'.
sudo apt install avahi-daemon
#
# Start the service.
sudo systemctl start avahi-daemon
#
# Enable auto-start at boot time.
sudo systemctl enable avahi-daemon
#
# Avahi-daemon listens on 'UDP:5353', so you need to open this port in the firewall. 
# If you use UFW, then run the following command.
sudo ufw allow 5353/udp
#
# Then you should set a unique hostname for your Ubuntu box with the 'hostnamectl' command. 
# Replace ubuntubox with your preferred hostname, which should not be already taken by other devices in the local network.
#
sudo hostnamectl set-hostname ubuntubox
#
# Now restart avahi-daemon.
sudo systemctl restart avahi-daemon
#
# If you check the status with
systemctl status avahi-daemon
# you can see the mDNS hostname, which ends with the .local domain.
#
#********************************************************************************************
# On the client computer, you also need to install an mDNS/DNS-SD software.
        # > Linux users should install avahi-daemon.
        # > Windows users need to enable the Bonjour service by either installing the Bonjour print service or installing iTunes.
        # > On macOS, Bonjour is pre-installed.
#
# Now you can access services by using the 'ubuntubox.local' hostname, eliminating the need to check and type IP address.
#********************************************************************************************
#
#----------------------------------------------------------------------------------------
# Unblock Wifi on Raspberry Pi --------------
#----------------------------------------------------------------------------------------
#
# The Ubuntu ARM OS for Raspberry Pi blocks wireless interface by default. You need to unblock it with:
sudo rfkill unblock wifi
#
# To unblock it at boot time, create a systemd service unit.
sudo nano /etc/systemd/system/unblock-wifi.service
#
# Add the following lines to it.
#
        # [Unit]
        # Description=RFKill Unblock WiFi Devices
        # Requires=wpa_supplicant.service
        # After=wpa_supplicant.service

        # [Service]
        # Type=oneshot
        # ExecStart=/usr/sbin/rfkill unblock wifi
        # ExecStop=
        # RemainAfterExit=yes

        # [Install]
        # WantedBy=multi-user.target
#
# Save and close the file. 
#
# Enable auto-start at boot time.
sudo systemctl enable unblock-wifi
#
# I found that the 'unblock-wifi.service' should run after the 'wpa_supplicant.service' starts, 
# otherwise it can’t unblock wifi. Note that if you have installed a desktop environment, 
# there’s probably a network manager running that can interfere with the connection. 
# You need to disable it. For example, I use the lightweight LXQT desktop environment on Raspberry Pi (sudo apt install lubuntu-desktop) 
# and need to disable 'connman.service' and 'NetworkManager.service'.
sudo systemctl disable connman.service NetworkManager.service
#
#----------------------------------------------------------------------------------------
# Multiple Wi-Fi Networks --------------
#----------------------------------------------------------------------------------------
# The '/etc/wpa_supplicant.conf' configuration file can include multiple Wi-Fi networks. 
# 'wpa_supplicant' will automatically select the best network based on the order of network blocks in the configuration file, network security level, and signal strength.
#
# To add a second Wi-Fi network, run
#  wpa_passphrase your-ESSID your-wifi-passphrase | sudo tee -a /etc/wpa_supplicant.conf
#
# Note that you need to use the -a option with the tee command, which will append, instead of deleting the original content, the new Wifi-network to the file.
#
#----------------------------------------------------------------------------------------
# Wi-Fi Security --------------
#----------------------------------------------------------------------------------------
# Do not use WPA2 TKIP or WPA2 TKIP+AES as the encryption method in your Wi-Fi router. 
# TKIP is not considered secure anymore. You can use WPA2-AES as the encryption method.
#
#
#
# reference : https://www.linuxbabe.com/ubuntu/connect-to-wi-fi-from-terminal-on-ubuntu-18-04-19-04-with-wpa-supplicant
#
