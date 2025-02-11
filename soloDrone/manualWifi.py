import sys
import paramiko
import time
import base64
import socket
import os
import tempfile
import urlparse
import urllib2

from distutils.version import LooseVersion
##
#   /home/pi/.local/lib/python2.7/site-packages/soloutils/
#   __init__.py
#   wifi.py
##
##

controller = '10.1.1.1'
solo = '10.1.1.10'

# This script operates in two stages: creating the script file
# and then executing it, so we are resilient to network dropouts.

SCRIPT3 = """
wget -O- http://example.com/ --timeout=5 >/dev/null 2>&1
"""

SCRIPT = """
cat > /tmp/timeout.sh << 'SCRIPT'
#!/bin/sh

# Execute a command with a timeout

# License: LGPLv2
# Author:
#    http://www.pixelbeat.org/
# Notes:
#    Note there is a timeout command packaged with coreutils since v7.0
#    If the timeout occurs the exit status is 124.
#    There is an asynchronous (and buggy) equivalent of this
#    script packaged with bash (under /usr/share/doc/ in my distro),
#    which I only noticed after writing this.
#    I noticed later again that there is a C equivalent of this packaged
#    with satan by Wietse Venema, and copied to forensics by Dan Farmer.
# Changes:
#    V1.0, Nov  3 2006, Initial release
#    V1.1, Nov 20 2007, Brad Greenlee <brad@footle.org>
#                       Make more portable by using the 'CHLD'
#                       signal spec rather than 17.
#    V1.3, Oct 29 2009, Jan Sarenik <jasan@x31.com>
#                       Even though this runs under dash,ksh etc.
#                       it doesn't actually timeout. So enforce bash for now.
#                       Also change exit on timeout from 128 to 124
#                       to match coreutils.
#    V2.0, Oct 30 2009, Jan Sarenik <jasan@x31.com>
#                       Rewritten to cover compatibility with other
#                       Bourne shell implementations (pdksh, dash)

if [ "$#" -lt "2" ]; then
    echo "Usage:   `basename $0` timeout_in_seconds command" >&2
    echo "Example: `basename $0` 2 sleep 3 || echo timeout" >&2
    exit 1
fi

cleanup()
{{
    trap - ALRM               #reset handler to default
    kill -ALRM $a 2>/dev/null #stop timer subshell if running
    kill $! 2>/dev/null &&    #kill last job
      exit 124                #exit with 124 if it was running
}}

watchit()
{{
    trap "cleanup" ALRM
    sleep $1& wait
    kill -ALRM $$
}}

watchit $1& a=$!         #start the timeout
shift                    #first param was timeout for sleep
trap "cleanup" ALRM INT  #cleanup after timeout
"$@"& wait $!; RET=$?    #start the job wait for it and save its return value
kill -ALRM $a            #send ALRM signal to watchit
wait $a                  #wait for watchit to finish cleanup
exit $RET                #return the value
SCRIPT

cat > /tmp/setupwifi.sh << 'SCRIPT'

# Delete old files
rm /mnt/rootfs.rw/lib/modules/3.10.17-rt12-*/kernel/net/ipv4/netfilter/iptable_filter.ko || true

/etc/init.d/hostapd stop
killall wpa_supplicant || true
killall udhcpc || true

cat <<EOF > /etc/wpa_client.conf
network={{
{credentials}
}}
EOF

echo 1 > /proc/sys/net/ipv4/ip_forward

sed -i.bak 's/dhcp-option=3.*/dhcp-option=3,10.1.1.1/g' /etc/dnsmasq.conf
sed -i.bak 's/dhcp-option=6.*/dhcp-option=6,8.8.8.8/g' /etc/dnsmasq.conf

/etc/init.d/dnsmasq restart
sleep 2

echo 'connecting to the internet...'
wpa_supplicant -i wlan0 -c /etc/wpa_client.conf -B

/tmp/timeout.sh 15 udhcpc -i wlan0 || {{
    echo -e "\\nerror: wrong credentials or couldn't connect to wifi network!\\n"
    ifconfig wlan0 down
}}

/etc/init.d/hostapd start

sleep 3
wget -O- http://example.com/ --timeout=5 >/dev/null 2>&1
if [[ $? -ne '0' ]]; then
    echo ''
    echo 'error: could not connect to the Internet!'
    echo 'please check your wifi credentials and try again.'
else
    echo 'setting up IP forwarding...'
    insmod /lib/modules/3.10.17-rt12-*/kernel/net/ipv4/netfilter/iptable_filter.ko 2>/dev/null
    iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
    iptables -A FORWARD -i wlan0 -o wlan0-ap -j ACCEPT
    iptables -A FORWARD -i wlan0-ap -o wlan0 -j ACCEPT
    echo ''
    echo 'success: Solo is now connected to the Internet.'
    echo 'if your computer does not yet have Internet access, try'
    echo "disconnecting and reconnecting to Solo's wifi network."
fi

SCRIPT

chmod +x /tmp/timeout.sh
chmod +x /tmp/setupwifi.sh
bash /tmp/setupwifi.sh > /log/setupwifi.log 2>&1
"""
#
#

#
#
clientController = paramiko.SSHClient()
#client.load_system_host_keys()
clientController.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#
clientController.connect(controller, username='root', password='TjSDBkAu', timeout=5)
#
#
print('connecting to encrypted wifi network.')
credentials = 'ssid="{ssid}"\npsk="{password}"'.format(ssid="hive", password="intelligence13")
cmd = SCRIPT.format(credentials=credentials)
#
#
chanController = clientController.get_transport().open_session()
chanController.exec_command(cmd)

codeController = chanController.recv_exit_status()
time.sleep(8)

clientController.close()

print(" codeController : ",codeController)
print('')
print('please manually reconnect to Solo\'s network once it becomes available.')
print('it may take up to 30s to a reconnect to succeed.')
#
clientSontroller = paramiko.SSHClient()
#client.load_system_host_keys()
clientController.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#
clientController.connect(controller, username='root', password='TjSDBkAu', timeout=5)
print('')
#
stdout=sys.stdout
stderr=sys.stderr
cmd = 'cat /log/setupwifi.log'
#
chanController = clientController.get_transport().open_session()
chanController.get_pty()
chanController.exec_command(cmd)
#
while True:
    time.sleep(0.1)
    if chanController.recv_ready():
        str = chanController.recv(4096).decode('ascii')
    if stdout:
        stdout.write(str)
    if chanController.recv_stderr_ready():
        str = chanController.recv_stderr(4096).decode('ascii')
    if stderr:
        stderr.write(str)
    if chanController.exit_status_ready():
        pass

codeController = chanController.recv_exit_status()

chanController.close()
clientController.close()


clientSolo = paramiko.SSHClient()
#client.load_system_host_keys()
clientSolo.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#
clientSolo.connect(solo, username='root', password='TjSDBkAu', timeout=5)
#
print('(resetting Solo\'s DNS...', sys.stdout.flush())
#
cmd = 'ifdown wlan0; ifdown -a; ifup -a; ifup wlan0'
chanSolo = clientSolo.get_transport().open_session()
#
chanSolo.exec_command(cmd)
#
stderr = ''
stdout = ''
while True:
        time.sleep(0.1)
        if chanSolo.recv_ready():
            stdout += chan.recv(4096).decode('ascii')
        if chanSolo.recv_stderr_ready():
            stderr += chan.recv_stderr(4096).decode('ascii')
        if chanSolo.exit_status_ready():
            break

codeSolo = chanSolo.recv_exit_status()
chanSolo.close()
#
print(codeSolo, stdout, stderr)
#
time.sleep(4)
clientSolo.close()
print(' DONE !')