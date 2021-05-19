#
#
sudo apt-get install software-properties-common
#
# -------------------------------------------------------------------------------------------
# install uv4l ( User space Video4Linux)
# -------------------------------------------------------------------------------------------
# To install Uv4l on Raspbian Wheezy add the following line to the file '/etc/apt/sources.list' :
#   deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/ buster main
#
# update and install
sudo apt-get update 
sudo apt-get install uv4l uv4l-raspicam 
#
#  If you want the driver to be loaded at boot, also install this optional package:
sudo apt-get install uv4l-raspicam-extras 
#
# Apart from the driver for the Raspberry Pi Camera Board, the following Streaming Server front-end and drivers can be optionally installed:
sudo apt-get install uv4l-server uv4l-uvc uv4l-xscreen uv4l-mjpegstream uv4l-dummy uv4l-raspidisp 
#
# If you are getting error in installing uv4l-server like required installer 'libssl1.0.0' 
# is not present so to install that we have to add line to /etc/apt/sources.list
deb http://ftp.de.debian.org/debian buster main  
sudo apt-get update
#
# The WebRTC extension for the Streaming Server is also available with 
# two alternative packages depending on the Raspberry Pi model in use.
#
# # If you have a Raspberry Pi 1, Zero or Zekro W (Wireless), type:
# sudo apt-get install uv4l-webrtc-armv6 
#
# For Raspberry Pi 2 or 3) type:
sudo apt-get install uv4l-webrtc  
#
# To restart the server:
sudo service uv4l_raspicam restart 
# It works on port 8080.  
#
# -------------------------------------------------------------------------------------------
# install ffmpeg
# -------------------------------------------------------------------------------------------
# Add the following line to the file /etc/apt/sources.list:
        #  deb http://www.deb-multimedia.org buster main non-free
#
# Update the list of available packages:
sudo apt-get update 
#
# Install ffmpeg by command:
sudo apt-get install ffmpeg