#
#
# 
# ---------------------------------------------------------------------------------------------------------------------------
#       Solo Major Update - Begin
# ---------------------------------------------------------------------------------------------------------------------------
#
# Install instructions for SSH/SFTP to upgrade from 3dr 1.3.1 to open solo 4
#
#   1- SSH into the copter with IP '10.1.1.10', username 'root', password 'TjSDBkAu'
#   2- Put the new 'pixhawk.py' and 'uploader.py' files in the '/usr/bin' directory with execute permissions
#       change permissions with:  
        chmod 777  /usr/bin/pixhawk.py 
        chmod 777 /usr/bin/uploader.py
#   3- Delete what you had in the '/firmware' folder
#   4- Reboot
#   5- Copy 'ardupilot.apj' or 'ArduCopter.4.0.1.CubeSolo.apj' (Dec 2019 version) to '/firmware'
#   6- Reboot and it should install ardupilot v4
#
# Then
#
#   1- SSH into the copter with IP '10.1.1.10', username 'root', password 'TjSDBkAu'.
#   2- to clean up and prepares the directories :
        sololink_config --update-prepare sololink
#   3- Copy '3dr-solo.tar.gz' and '3dr-solo.tar.gz.md5' to the /log/updates directory on the copter.
#   4- to execute the update and reboots : 
        sololink_config --update-apply sololink --reset
#
# And
#
#   1- SSH into the controller with IP '10.1.1.1', username 'root', password 'TjSDBkAu'
#   2- to cleans up and prepares the directories : 
        sololink_config --update-prepare sololink 
#   3- Copy '3dr-controller.tar.gz' and '3dr-controller.tar.gz.md5' to the '/log/updates' directory on the controller.
#   4- to execute the update and reboots :
        sololink_config --update-apply sololink --reset 
#
# Then:
#
#   1- SSH into the copter with IP '10.1.1.10', username 'root', password 'TjSDBkAu'.
#   2- to execute the update. Disconnect when complete : 
        sololink_config --make-golden 
#   3- SSH into the controller with IP '10.1.1.1', username 'root', password 'TjSDBkAu'
#   4- to execute the update. Disconnect when complete.
        sololink_config --make-golden 
#
# possible mistake : 
#        - They just did not address updating from the old 3DR firmware to open solo for the black cube via SSH.     
#
# questions :
#        - Should anything be done with artoo_2019-09-29_01-59.bin??
#
# installation files : ../firmware/solodrone/
#
# (reference : https://3drpilots.com/threads/update-1-3-1-to-open-solo-4-dev-via-ssh-sftp.15379/)
#
# Warnings !!!! :
#   - When you do that ArduCopter firmware update, it may not give you the final happy tones/lights. 
#      So if after a few minutes it is still just sitting there, manually power cycle the copter. 
#      It should power up again happy and glad with ArduCopter 4.0 installed 
#      (it is 4.0, not 3.7 at this point).
#   - The old 3DR app is not compatible with many many things today. It hasn't been updated by 3DR since 2016. 
#
# ---------------------------------------------------------------------------------------------------------------------------
#       Solo Major Update - End
# ---------------------------------------------------------------------------------------------------------------------------
# # #
# # #
# ---------------------------------------------------------------------------------------------------------------------------
#       Solo-Cli installation - Begin
# ---------------------------------------------------------------------------------------------------------------------------
# Check the alternative solo-cli installations given :
#   - https://3drobotics.github.io/solodevguide/starting-utils.html
#   - https://wiki.nps.edu/pages/viewpage.action?pageId=864354593
#   - https://github.com/3drobotics/solo-cli
#
# ---------------------------------------------------------------------------------------------------------------------------
#       Solo-Cli installation - End
# ---------------------------------------------------------------------------------------------------------------------------
# # #
# # #
# ---------------------------------------------------------------------------------------------------------------------------
#       Usefull Links - Begin
# ---------------------------------------------------------------------------------------------------------------------------
# - https://3drpilots.com/threads/solo-cli-seems-to-no-longer-be-supported.15929/
# - https://3drpilots.com/threads/connecting-to-the-internet-using-solo-cli.6937/page-2
# - https://3drpilots.com/threads/update-1-3-1-to-open-solo-4-dev-via-ssh-sftp.15379/
# ---------------------------------------------------------------------------------------------------------------------------
#       Usefull Links - End
# ---------------------------------------------------------------------------------------------------------------------------