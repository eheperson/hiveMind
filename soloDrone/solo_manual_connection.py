import paramiko 
import socket
import time
##
#   /home/pi/.local/lib/python2.7/site-packages/soloutils/
#   __init__.py
#   info.py
##
##
controller = '10.1.1.1'
solo = '10.1.1.10'
##
#--------------------------------------------------------------------------
#- Solo Vehicle Info Get - Begin
#--------------------------------------------------------------------------
clientSolo = paramiko.SSHClient()
clientSolo.load_system_host_keys()
clientSolo.set_missing_host_key_policy(paramiko.AutoAddPolicy())
clientSolo.connect(solo, username='root', password='TjSDBkAu', timeout=5)
#
chanSolo = clientSolo.get_transport().open_session()
chanSolo.exec_command('cat /VERSION')
#
stderr = ''
stdout = ''
#
time.sleep(0.1)
if chanSolo.recv_ready():
    stdout += chanSolo.recv(4096).decode('ascii')
if chanSolo.recv_stderr_ready():
    stderr += chanSolo.recv_stderr(4096).decode('ascii')
if chanSolo.exit_status_ready():
    print("chanSolo exit status read ")
codeSolo = chanSolo.recv_exit_status()
chanSolo.close()
# solorStr = stdout
print(stdout)
#--------------------------------------------------------------------------
#- Solo Vehicle Info Get - End
#--------------------------------------------------------------------------
#
#
#--------------------------------------------------------------------------
#- Solo Controller Info Get - Begin
#--------------------------------------------------------------------------
clientController = paramiko.SSHClient()
clientController.load_system_host_keys()
clientController.set_missing_host_key_policy(paramiko.AutoAddPolicy())
clientController.connect(controller, username='root', password='TjSDBkAu', timeout=5)
#
chanController = clientController.get_transport().open_session()
chanController.exec_command('cat /VERSION')
#
stderr = ''
stdout = ''
#
time.sleep(0.1)
if chanController.recv_ready():
    stdout += chanController.recv(4096).decode('ascii')
if chanController.recv_stderr_ready():
    stderr += chanController.recv_stderr(4096).decode('ascii')
if chanController.exit_status_ready():
    print("exit status read ")
codeController = chanController.recv_exit_status()
chanController.close()
# controllerStr = stdout
print(stdout)
#--------------------------------------------------------------------------
#- Solo Controller Info Get - End
#--------------------------------------------------------------------------
#