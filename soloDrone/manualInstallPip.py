import sys
import paramiko
import time
import socket
import os
import tempfile
import urlparse
import urllib2
#
import base64, soloutils
from distutils.version import LooseVersion
#
from scp import SCPClient
import posixpath
#
import soloManual
##
#   /home/pi/.local/lib/python2.7/site-packages/soloutils/
#   __init__.py
#   install_runit.py
##
##
#
controller = '10.1.1.1'
solo = '10.1.1.1'
flag = 0
#
#
soloClient = soloManual.soloConnect()
#
scp = SCPClient(soloClient.get_transport())
#
code, stdout, stderr = soloManual.command(soloClient, 'pip --version')
if code != 0:
    print("Installing Pip..")
    scp.put(os.path.join(os.path.dirname(__file__), 'lib/ez_setup.py'), '/tmp')
    scp.put(os.path.join(os.path.dirname(__file__), 'lib/setuptools-18.7.1.zip'), '/tmp')
    code, stdout, stderr = soloManual.command(soloClient, 'cd /tmp; python ez_setup.py --to-dir=/tmp')
    if code:
        print("")
        print("Error in installing pip : ")
        print(strout)
        print(stderr)
        flag = 1
    print("Done !")
#
code, stdout, stderr = soloManual.command(soloClient, 'python -c "import wheel"')
if code != 0:
    print("Installing Wheel..")
    scp.put(os.path.join(os.path.dirname(__file__), 'lib/wheel-0.26.0.tar.gz'), '/tmp')
    code, stdout, stderr = soloManual.command(soloClient, 'pip install /tmp/wheel-0.26.0.tar.gz')
    if code:
        print("")
        print("Error in installing Wheel : ")
        print(strout)
        print(stderr)
        flag = 1
    print("Done !")
#
code, stdout, stderr = soloManual.command(soloClient, 'virtualenv --version')
if code != 0:
    print("Installing Virtualenv..")
    scp.put(os.path.join(os.path.dirname(__file__), 'lib/virtualenv-13.1.2.tar.gz'), '/tmp')
    code, stdout, stderr = soloManual.command(soloClient, 'pip install /tmp/virtualenv-13.1.2.tar.gz')
    if code:
        print("")
        print("Error in installing Virtualenv : ")
        print(strout)
        print(stderr)
        flag = 1
    print("Done !")
    #
    if flag == 0:
        print("Pip is ready to use")
#
scp.close()
soloManual.clientClose(soloClient)
#
sys.exit(flag)