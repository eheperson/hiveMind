###########################################################################################################################
###########################################################################################################################
#
# Follow the procedures for Connecting Solo to WiFi, then proceed. >>> soloWifiConnection.sh
#
# First time solo CLI 
# Ensure you are still connected to the solo network (you do not need to be SSH'd in). 

# The first time we run solo CLI, we want to install a few repositories on the solo. 
# Install all of the following libraries. 
#
# 1 - install smart : 
solo install-smart
#
# 2 - install runit : 
solo install-runit
#
# 3 - install pip :
solo install-pip
#
# 4 - install DroneKit script pack :
solo script pack
#
#
###########################################################################################################################
######################## Installation NOTEs ###############################################################################
###########################################################################################################################
#--------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------
#
# If successful:
#       The command will create an archive in the 'solo-script.tar.gz' in the current directory.
# 
#       Deploy this archive to Solo and run a specified script using the 'solo script run <scripname>' command. 
#
#!!!! The host computer must be connected to the Solo wifi network, and Solo must also be connected to the Internet.
#
# For example, to deploy and run the helloworld example:
#           $solo script run helloworld.py
#--------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------
# Troubleshooting: If you get the error shown below, reboot the controller adn
#  repeat steps : 
#               1 - install smart
#               2 - install runit
#
#       NOTE: this process requires simultaneous access to
#       Solo and to the Internet. if you have not yet done so,
#       run `solo wifi` to connect to Solo and to a local
#       wifi connection simultaneously.
#
#       connecting to solo...
#       waiting for Internet connectivity...
#
#       Loading cache...
#       Updating cache...               ######################################## [100%]
#
#       error: busybox-1.21.1-r1@cortexa9hf_vfp_neon is not available for downloading
#--------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------
###########################################################################################################################
###########################################################################################################################
