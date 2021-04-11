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
#   install_runit.py
##
##
#
controller = '10.1.1.1'
solo = '10.1.1.1'
#
SCRIPT = """
# This script will install runit as a process spawned by /etc/inittab
# to monitor services under /etc/solo-services under runlevel 4

need() {
    for var in "$@"; do
        which "$var" >/dev/null
        if [ $? != 0 ]; then
            return 1
        fi
    done
}

set -e

need "sv" || {
        cd /tmp
        smart download busybox
        rpm -iv --replacepkgs busybox-*
}

# This function ensures that a line exists in a given file.
# If it doesn't, it adds it.
lineinfile () {
    FILE=$1
    LINE=$2
    grep -q "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
}

echo 'setting up /etc/solo-services directory...'

# First create the directory where our services will live.
mkdir -p /etc/solo-services

# We require a script called /sbin/solo-services-start.
# This will be launched on startup as a long-lived process
# (under runlevel 4) that monitors the /etc/solo-services
# directory and respawns services that live there.
# Lookup runsvdir(8) for more information on how this works.
cat <<'EOF' > /sbin/solo-services-start
#!/bin/sh
PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin
exec env - PATH=$PATH \
runsvdir -P /etc/solo-services "log: $(printf '.%.0s' {1..395})"
EOF
chmod +x /sbin/solo-services-start

# We add /sbin/solo-services-start as a startup script.
lineinfile "/etc/inittab" "SSS:4:respawn:/sbin/solo-services-start"
echo "export SVDIR=/etc/solo-services" > /etc/profile.d/solo-services

# Tell the OS to re-read /etc/inittab and immediately
# launch all services.
init q

echo ''
echo 'runit is now ready to use.'
"""
#
#
#
print('NOTE: this process requires simultaneous access to')
print('Solo and to the Internet. if you have not yet done so,')
print('run `solo wifi` to connect to Solo and to a local')
print('wifi connection simultaneously.')
print('')
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