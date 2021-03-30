##################################################################################################
##################################################################################################
##################################################################################################
#
#	reference    : https://github.com/OpenSolo/OpenSolo/wiki/Install-via-SSH
#	update files : https://github.com/OpenSolo/OpenSolo/releases
#
# We need these files for update process :
#  > 3dr-controller.tar.gz
#  > 3dr-controller.tar.gz.md5
#  > 3dr-solo.tar.gz
#  > 3dr-solo.tar.gz.md5
#
# these files could be installed from 'ubdate files' link above
#
# After files installed, open a terminal in the directory of those downloaded files
# Copy thet script to that directory 
# Run these commands given below :
#
##################################################################################################
##################################################################################################
# # # # # # # # # # # # # # # # # # #
# Pre-Installation Section - Begin ##
# # # # # # # # # # # # # # # # # # #
#
# As first step :
# # Connect to the 3dr-network
# default password is : 'sololink'
#
# # # # # # # # # # # # # # # # # #
# Pre-Installation Section - End ##
# # # # # # # # # # # # # # # # # #
##################################################################################################
##################################################################################################
# # # # # # # # # # # # # # # # # # # # # # # # #
# 3DR-Solo Drone system Update section - Begin ##
# # # # # # # # # # # # # # # # # # # # # # # # #
#
# Connect to the 3RD-Solo Drone via SSH
# password for ssh : TjSDBkAu
ssh root@10.1.1.10
#
# cleans up and prepares the directories.
sololink_config --update-prepare sololink
#
#exit ssh
exit
#
# scp syntax : scp <source> <destination>
# Copy installed 3dr-solo drone update files via ssh 
scp ./3dr-solo.tar.gz root@10.1.1.10:/log/updates
scp ./3dr-solo.tar.gz.md5 root@10.1.1.10:/log/updates 
#
# Connect to the 3RD-Solo Drone via SSHs
# password for ssh : TjSDBkAu
ssh root@10.1.1.10
#
# execute the update and reboots.
sololink_config --update-apply sololink --reset 
#
# # # # # # # # # # # # # # # # # # # # # # # #
# 3DR-Solo Drone system Update section - End ##
# # # # # # # # # # # # # # # # # # # # # # # #
##################################################################################################
##################################################################################################
##################################################################################################
# # # # # # # # # # # # # # # # # # # # # # # # # # ##
# 3DR-Solo Controller system Update section - Begin ##
# # # # # # # # # # # # # # # # # # # # # # # # # # ##
#
# Connect to the 3RD-Solo Drone via SSHs
# password for ssh : TjSDBkAu
ssh root@10.1.1.1
#
# execute the update and reboots.
sololink_config --update-apply sololink --reset 
#
# exit ssh
exit
#
# Sopy installed controller update files via ssh
scp ./3dr-controller.tar.gz root@10.1.1.1:/log/updates
scp ./3dr-controller.tar.gz.md5  root@10.1.1.1:/log/updates
#
# Connect to the 3RD-Solo Drone via SSHs
# password for ssh : TjSDBkAu
ssh root@10.1.1.1
#
# execute the update and reboots.
sololink_config --update-apply sololink --reset 
#
# # # # # # # # # # # # # # # # # # # # # # # # # ##
# 3DR-Solo Controller system Update section - End ##
# # # # # # # # # # # # # # # # # # # # # # # # # ##
##################################################################################################
##################################################################################################
##################################################################################################
