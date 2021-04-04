#
#
#### STEP - 1 ####
#
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
#add those setting lines : 
#
# ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
# update_config=1
# country=TR
#
# network={
#         ssid="SoloLink_43F634"
#         psk="sololink"
#         key_mgmt=WPA-PSK
#         scan_ssid=1
# }
#
#
#### STEP - 2 ####
# On Debian, to configure your Wi-Fi network interface very easily
# you can add your Wi-Fi network details in the :
#        /etc/network/interfaces.d/wlan0
nano /etc/network/interfaces.d/wlan0
#
#  add those lines : 
#
# allow-hotplug wlan0
# iface wlan0 inet dhcp
#         wpa-ssid SoloLink_43F634
#         wpa-psk sololink
#
# Assuming you are using wlan0(usb wifi adapter) as wifi acces point
# and
# wlan1(onboard wifi adapter) is seperated for the SoloLink-xxx wifi network connection.
#
# if any usb wifi dongl connected to the rpi at power-on
# Rpi assign wlan1 to on board wifi card and,
# wlan0 to usb(external) wifi card.








