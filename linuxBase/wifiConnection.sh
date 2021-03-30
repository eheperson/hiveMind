#
#
# To connec wifi
#
sudo su
#
iwconfig wlan0 up
#16091922
# to scan wifi networks
iwlist wlan0 scan | grep ESSID

wpa_passphrase "EZGIEDA" "16091922" | tee /etc/wpa_supplicant.conf
#
#
sudo wpa_supplicant -c /etc/wpa_supplicant.conf wlan0