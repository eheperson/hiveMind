#
#
#
#-------------------------------------------------------------------
#   PREREQUISITIES
#-------------------------------------------------------------------
# Installing bootstrap dependencies
sudo apt-get install python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential
#
# Initializing rosdep
sudo rosdep init
rosdep update
#
#-------------------------------------------------------------------
#   INSTALLATION
#-------------------------------------------------------------------
# building the core ROS(catkin) packages
#       ROS is in the process of converting to the catkin build system,
#       but not all of the packages have been converted and the two build systems cannot be used simultaneously. 
#       Therefore it is necessary to build the core ROS packages first (catkin packages) and then the rest.
#
# Create a catkin Workspace
#       In order to build the core packages, you will need a catkin workspace. Create one now:
mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws
#
#
# Fetch the core packages to build them
#       We will use wstool for this. 
#       Select the wstool command for the particular variant you want to install:
#
#----Desktop-Full Install: ROS, rqt, rviz, robot-generic libraries, 2D/3D simulators, navigation and 2D/3D perception
rosinstall_generator desktop_full --rosdistro kinetic --deps --wet-only --tar > kinetic-desktop-full-wet.rosinstall
wstool init -j8 src kinetic-desktop-full-wet.rosinstall
#
#----Desktop Install (recommended): ROS, rqt, rviz, and robot-generic libraries
rosinstall_generator desktop --rosdistro kinetic --deps --wet-only --tar > kinetic-desktop-wet.rosinstall
wstool init -j8 src kinetic-desktop-wet.rosinstall
#
#----ROS-Comm: (Bare Bones) ROS package, build, and communication libraries. No GUI tools.
rosinstall_generator ros_comm --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm-wet.rosinstall
wstool init -j8 src kinetic-ros_comm-wet.rosinstall
#
#       - The -j8 option downloads 8 packages in parallel.
#       - If wstool init fails or is interrupted, you can resume the download by running:
#                wstool update -j 4 -t src
#
#
# Resolving Dependencies
#   Before you can build your catkin workspace you need to make sure that you have all the required dependencies
rosdep install --from-paths src --ignore-src --rosdistro kinetic -y
#
#
#
#