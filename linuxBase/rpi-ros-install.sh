####
### 
##
# Instructions to install ROS-Kinetic on Rpi-3B+
# reference : http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Kinetic%20on%20the%20Raspberry%20Pi
#
# Hardware  :   Raspberry PI Model 3B+  
# OS        :   Debian Buster based Raspbian OS
# ROS ver   :   Kinetic
#
#   - That instructions
###
####
#
#-------------------------------------------------------------------
#   PREREQUISITIES
#-------------------------------------------------------------------
# Setup ROS Repositories
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
#
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
#
# Update Debian Package Index
sudo apt-get update
sudo apt-get upgrade
#
# Install Bootstrap Dependencies
sudo apt-get install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake
#
# Installing rosdep
sudo rosdep init
rosdep update
#
#-------------------------------------------------------------------
#   INSTALLATION
#-------------------------------------------------------------------
# Create a catkin Workspace
mkdir -p ~/catkin_ws
cd ~/catkin_ws
#
# Fetch the core packages so we can build them :  We will use wstool for this. Select the wstool command for the particular variant you want to install: