#
#
#
#
# downloads.fars-robotics.net 
#              |
#              - wifi-drivers 
#                      |
#                      - 8188eu-drivers
#                      - 8192eu-drivers
#                      - 8812au-drivers
# 		     - 8822bu-drivers
#                      - mt7610-drivers
#                      - mt7612-drivers
#
#
#
# first check linux kernel version by : 
#   uname -a
#
# in my case output is : 
#   Linux raspberrypi 5.10.17-v7+ #1403 SMP Mon Feb 22 11:29:51 GMT 2021 armv7l GNU/Linux
#
# Importrant point of that output is : 
#   5.10.17-v7+ #1403
#
# I need that versioningthing to install correct driver
#   8188eu-5.10.17-v7-1403.tar.gz
#
wget http://downloads.fars-robotics.net/wifi-drivers/8188eu-drivers/8188eu-5.10.17-v7-1403.tar.gz
#
#
tar xzf 8188eu-5.10.17-v7-1403.tar.gz
#
#
./install.sh
#
#
# check later :
# sudo wget http://downloads.fars-robotics.net/wifi-drivers/install-wifi -O /usr/bin/install-wifi
# sudo chmod +x /usr/bin/install-wifi