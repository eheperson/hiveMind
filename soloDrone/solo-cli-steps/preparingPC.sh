#
#
####################################################################
# Preparing your Computer
###################################################################
# Setting up your computer: Solo Command Line Tool (Solo CLI Tool). 
#
#  !! The Solo CLI should be installed on the PC to execute solo commands  
#
#
sudo pip uninstall solo-cli -y || true
#   Connect to valid WiFi network with internet and run:
sudo -H pip install git+https://github.com/3drobotics/solo-cli
#or
sh sudo -H pip install git+https://github.com/3drobotics/solo-cli 
# or
sudo pip install https://github.com/3drobotics/solo-cli/archive/master.zip --no-cache-dir
#
###################################################################
#---------------- Optional - Begin -------------------------------#
###################################################################
#If you get an error: 
#       "distutils.errors.DistutilsError: Setup script exited with error: command 'x86_64-linux-gnu-gcc' failed with exit status 1"
# run this and then try again:
sudo apt-get install libffi-dev
sudo apt-get install libssl-dev
sudo apt-get install python-dev
#
#
# if you get an error:
#       "ImportError: No module named virtualenv"
# you should run:
sudo pip install virtualenv
#
###################################################################
#---------------- Optional - End ---------------------------------#
###################################################################
# 
# Reconnect to the solo's wifi network. 
# You can now run run solo commands. 
#!!!!! You MUST be connected to the solo network for these commands to execute properly. 
#
# To see all solo commands, use command "solo":
#
# First time running solo command :
solo info
#
#
#