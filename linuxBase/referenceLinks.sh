


mkdir hive
cd hive
#
#
#
# Prerequisities for Husairon ROSBot: 
#   > GNU Arm Embedded version 6 toolchain
#   > Mbed CLI
# Prerequisities for 3DR Solo Drone: 
#
#
# gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
# GNU_ARM_EMBED_URL="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2"
GNU_ARM_EMBED_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2"
#
#
# Python development tools installation
sudo apt-get install python-pip -y
sudo apt-get install python-dev -y
#
sudo apt-get install python3-pip -y
sudo apt-get install python3-dev -y
#
# Required Tools for Python
sudo apt-get install libxml2-dev -y
sudo apt-get install libxslt-dev -y
sudo apt-get install python-lxml
sudo apt-get install python3-lxml
#
# Required Tools for solo-cli
sudo apt-get install libzbar-dev -y 
sudo apt-get install libzbar0 -y
#
# Installing virtualenv : 
sudo pip3 install virtualenv
#
#Creating virtual environments for Python3 and Python2
virtualenv --python=/usr/bin/python2.7 hivePy27
virtualenv --python=/usr/bin/python3.7 hivePy37
#
# Python DroneKit Module Installation
source hivePy37/bin/activate
pip install lxml
pip install dronekit
pip install dronekit-sitl
deactivate
#
source hivePy27/bin/activate
pip install lxml
pip install dronekit
pip install dronekit-sitl
deactivate
#
# Creating virtual env for solo-cli (for testing purposes)
virtualenv --python=/usr/bin/python2.7 soloCli
source soloCli/bin/activate

git clone https://github.com/3drobotics/solo-cli.git

####-----------------------------------------------------------------------------------
####-----------------------------------------------------------------------------------
apt-get build-dep -y lxml









# GNU Arm Embedded Cli Installation
wget $GNU_ARM_EMBED_URL



vehicle = connect("udpin:0.0.0.0:14550", wait_ready=True, baud=57600, heartbeat_timeout=30) or
vehicle = connect("udpin:0.0.0.0:14550", wait_ready=False)
vehicle = connect("127.0.0.1:14550", wait_ready=False)  


#
#
opencv
sudo apt-get install python3-opencv
sudo apt-get install libhdf5-dev
sudo apt-get install libhdf5-serial-dev
sudo apt-get install libatlas-base-dev
sudo apt-get install libjasper-dev 
sudo apt-get install libqtgui4 




    cap = cv2.VideoCapture('udp://10.1.1.1:5600',cv2.CAP_FFMPEG)
    if not cap.isOpened():
        print('VideoCapture not opened')
        exit(-1)

    while True:
        ret, frame = cap.read()

        if not ret:
            print('frame empty')
            break

        cv2.imshow('image', frame)

        if cv2.waitKey(1)&0XFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()


rtsp://10.1.1.1:5502/sololink.sdp
cap = cv2.VideoCapture("rtsp://192.168.1.100:8554/video1.sdp")
rtsp://root:mypassword@192.168.1.105/axis-media/media.amp
cap = cv2.VideoCapture("rtsp://root:mypassword@192.168.1.105/axis-media/media.amp")

cap = cv2.VideoCapture("rtsp://10.1.1.1:5502/sololink.sdp")


pip install rtsp
# RTSP_URL = f"rtsp://{USERNAME}:{PASSWORD}@192.168.1.221:554/11"
import rtsp
client = rtsp.Client(rtsp_server_uri = 'rtsp://root:TjSDBkAu@10.1.1.1:5502/sololink.sdp')
client.read().show()
client.close()





from pymavlink import mavutil
# Start a connection listening to a UDP port
the_connection = mavutil.mavlink_connection('udpin:0.0.0.0:14550')
# Wait for the first heartbeat 
#   This sets the system and component ID of remote system for the link
the_connection.wait_heartbeat()
print("Heartbeat from system (system %u component %u)" % (the_connection.target_system, the_connection.target_system))

# Once connected, use 'the_connection' to get and send messages