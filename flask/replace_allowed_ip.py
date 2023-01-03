import socket
import os,re

local_ip = socket.gethostbyname('yourdomainname')
line_new ="ALLOWED_IPS = ['replace_IP1','replace_IP2','"+local_ip+"']\n"
#print(line_new)

os.remove('/root/restapi/temp') 
og=open('flask_restapi_py_path','r')
temp=open('/root/restapi/temp','w')
number=0
for i in og:
    number += 1
    if number==24:
       i=line_new
    temp.write(i)

og.close()
temp.close()

os.remove('flask_restapi_py_path')
temp=open('/root/restapi/temp','r')
og=open('flask_restapi_py_path','w')
number=0
for i in temp:
    number += 1
    og.write(i)

og.close()
temp.close()

os._exit(0)
