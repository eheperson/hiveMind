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
#
controller = '10.1.1.1'
solo = '10.1.1.10'
username = 'root'
password = password='TjSDBkAu'
#
def controllerConenct():
    """
    """
    print("Connecting to Solo-Controller..")
    clientController = paramiko.SSHClient()
    #clientController.load_system_host_keys()
    clientController.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    clientController.connect(controller, username=username, password=password, timeout=5)
    #
    return clientController
#
def soloConnect():
    """
    """
    print("Connecting to Solo-Drone..")
    clientSolo = paramiko.SSHClient()
    #clientSolo.load_system_host_keys()
    clientSolo.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    clientSolo.connect(solo, username=username, password=password, timeout=5)
    #
    return  clientSolo
#
def clientConnect(ip):
    """
    """
    print("Connecting to Client..")
    clientSolo = paramiko.SSHClient()
    #clientSolo.load_system_host_keys()
    clientSolo.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    clientSolo.connect(ip, username=username, password=password, timeout=5)
    #
    return  client
#
def clientClose(client):
    """
    """
    client.close()
#
def command(client, cmd):
    """
    to see version : cmd = 'cat /VERSION'
    """
    chan= client.get_transport().open_session()
    chan.exec_command(cmd)
    #
    stderr = ''
    stdout = ''
    #
    time.sleep(0.1)
    if chan.recv_ready():
        stdout += chan.recv(4096).decode('ascii')
    if chan.recv_stderr_ready():
        stderr += chan.recv_stderr(4096).decode('ascii')
    if chan.exit_status_ready():
        print("chan exit status readed. ")
    #
    code = chan.recv_exit_status()
    chan.close()
    #
    return code, stdout, stderr