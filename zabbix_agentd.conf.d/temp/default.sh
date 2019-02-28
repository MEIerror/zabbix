#!/usr/bin/env python
#coding:utf-8


import os, json
portlist=["3306","80","22"]

port_list=[]
port_dict={"data":None}
#cmd='''netstat -tnlp|egrep -i "$1"|awk {'print $4'}|awk -F':' '{if ($NF~/^[0-9]*$/) print $NF}'|sort |uniq   2>/dev/null'''
#local_ports=os.popen(cmd).readlines()
 
#for port in local_ports:
for port in portlist:
    pdict={}
    pdict["{#TCP_PORT}"]=port.replace("\n", "")
    port_list.append(pdict)
 
port_dict["data"]=port_list
jsonStr = json.dumps(port_dict, sort_keys=True, indent=4)
 
print jsonStr
print port_list
