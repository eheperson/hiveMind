#
#
# Clone one of the following repos from github : 
#           $git clone https://github.com/awilliams84/solo.git
#
#
# Connect to the Solo network created when the controller and vehicle connect together (likely named SoloLink_<name>). 
# On the Solo's network, you can connect to the vehicle as a UDP client :  'udpin:0.0.0.0:14550'
#
# Run a simple script to ensure that everything is working. 
# Navigate to the directory that contains 'solohello.py' and execute the script. 
# The key is declaring your vehicle.
python solohello.py
#
# If successful, you should see a response the looks similar to this:
#
#            Connecting to solo: udpin:0.0.0.0:14550
#            >>> APM:Copter to solo-1.3.1 (7e9206cc)
#            >>> PX4: 5e693274 NuttX: d48fa307
#            >>> Frame: QUAD
#            >>> PX4v2 004B0041 31355107 36333436
#            Get some vehicle attribute values:
#            GPS: GPSInfo:fix=3, num_sat=10
#            Battery: Battery:voltage=15.254, current=0.62, level=42
#            Last Heartbeat: 1.019366146
#            Is Armable?: True
#            System status: STANDBY
#            Mode: LOITER
#            Completed
#
#
