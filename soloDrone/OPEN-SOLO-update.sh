########################################################
########################################################
# You will need the following files:

    # 3dr-solo.tar.gz
    # 3dr-solo.tar.gz.md5
    # 3dr-controller.tar.gz
    # 3dr-controller.tar.gz.md5

# All files already installed to
#   ./firmware/solodrone/openSoo-update-files
#
#   (https://github.com/OpenSolo/OpenSolo/releases)
#
########################################################
########################################################
#
# Updating Copter IMX : 
    # 1- SSH into the copter with IP 10.1.1.10, username root, password TjSDBkAu.
    # 2- # sololink_config --update-prepare sololink cleans up and prepares the directories.
    # 3- Copy 3dr-solo.tar.gz and 3dr-solo.tar.gz.md5 to the /log/updates directory on the copter.
    # 4- # sololink_config --update-apply sololink --reset executes the update and reboots.
#
#
#
# Updating Controller IMX :
    # 1- SSH into the controller with IP 10.1.1.1, username root, password TjSDBkAu
    # 2- # sololink_config --update-prepare sololink cleans up and prepares the directories.
    # 3- Copy 3dr-controller.tar.gz and 3dr-controller.tar.gz.md5 to the /log/updates directory on the controller.
    # 4- # sololink_config --update-apply sololink --reset executes the update and reboots.
#
########################################################
########################################################
#
# Golden Image (Factory Reset) Partition Update : 
#
#       Once the copter and controller are updated, 
#       you can now make your factory reset partition Open Solo as well. 
#       This is highly recommended. Otherwise a factory reset will put you 
#       back to the old unusable 3DR golden image. The process is the same 
#       for the copter and controller. With Open Solo, if you do a factory reset, 
#       it will automatically reinstall a clean version of Open Solo back to the 
#       system partition, reset ArduCopter parameters, and get you fully operational 
#       again. No internet or manual updates required.
#
#####
    # 1- SSH into the copter with IP 10.1.1.10, username root, password TjSDBkAu.
    # 2- # sololink_config --make-golden executes the update. Disconnect when complete.
    # 3- SSH into the controller with IP 10.1.1.1, username root, password TjSDBkAu
    # 4- # sololink_config --make-golden executes the update. Disconnect when complete.