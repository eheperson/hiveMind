import sys
import paramiko
import time
import socket
import os
import tempfile
import urlparse
import urllib2

import base64, soloutils
from distutils.version import LooseVersion
##
#   /home/pi/.local/lib/python2.7/site-packages/soloutils/
#   __init__.py
#   install_smart.py
##
##
#
controller = '10.1.1.1'
solo = '10.1.1.1'
#
SCRIPT = """
# Patch smart to allow --remove-all
# See http://lists.openembedded.org/pipermail/openembedded-core/2014-July/095090.html
# But ather than reinstall smart, just patch the Python code
sed -i.bak 's/, \"remove-all\",/, \"remove_all\",/g' /usr/lib/python2.7/site-packages/smart/commands/channel.py

PACKAGE_URL="http://solo-packages.s3-website-us-east-1.amazonaws.com"

printf 'setting up repositories.'; smart channel --remove-all -y 2>&1 | xargs
printf 'rpmsys...'; smart channel --add rpmsys type=rpm-sys name='RPM Database' -y
printf 'all...'; smart channel --add all type=rpm-md baseurl=$PACKAGE_URL/3.10.17-rt12/all/ -y
printf 'cortexa9hf_vfp_neon...'; smart channel --add cortexa9hf_vfp_neon type=rpm-md baseurl=$PACKAGE_URL/3.10.17-rt12/cortexa9hf_vfp_neon/ -y
printf 'cortexa9hf_vfp_neon_mx6...'; smart channel --add cortexa9hf_vfp_neon_mx6 type=rpm-md baseurl=$PACKAGE_URL/3.10.17-rt12/cortexa9hf_vfp_neon_mx6/ -y
printf 'imx6solo_3dr_1080p...'; smart channel --add imx6solo_3dr_1080p type=rpm-md baseurl=$PACKAGE_URL/3.10.17-rt12/imx6solo_3dr_1080p/ -y

echo ''
smart update

echo ''
echo 'smart package manager is now ready to use.'
"""
#
#
print('NOTE: this process requires simultaneous access to')
print('Solo and to the Internet. if you have not yet done so,')
print('run `solo wifi` to connect to Solo and to a local')
print('wifi connection simultaneously.')
print('')
#
#
print ('connecting to solo...')
clientSolo = paramiko.SSHClient()
#client.load_system_host_keys()
clientSolo.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#
clientSolo.connect(solo, username='root', password='TjSDBkAu', timeout=5)
#
#
print('waiting for Internet connectivity...')
socket.setdefaulttimeout(5)
while True:
    try:
        socket.gethostbyname('example.com')
    except KeyboardInterrupt as e:
        raise e
    except Exception as e:
        time.sleep(0.1)
        continue

    try:
        request = urllib2.Request('http://example.com/')
        urllib2.urlopen(request)
    except KeyboardInterrupt as e:
        raise e
    except Exception as e:
        time.sleep(0.1)
        continue
    else:
        break
#
#
print("Internet connection is verificated ..")
stdout=sys.stdout
stderr=sys.stderr
cmd = SCRIPT
#
chanSolo = clientSolo.get_transport().open_session()
chanSolo.get_pty()
chanSolo.exec_command(cmd)
#
while True:
    time.sleep(0.1)
    if chanSolo.recv_ready():
        str = chanSolo.recv(4096).decode('ascii')
        if stdout:
            stdout.write(str)
    if chanSolo.recv_stderr_ready():
        str = chanSolo.recv_stderr(4096).decode('ascii')
        if stderr:
            stderr.write(str)
    if chanSolo.exit_status_ready():
        break
codeSolo = chanSolo.recv_exit_status()
#
chanSolo.close()
clientSolo.close()
#
sys.exit(codeSolo)