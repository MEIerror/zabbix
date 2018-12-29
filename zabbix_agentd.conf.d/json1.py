#!/bin/env python
#-*- coding:utf-8 -*-

import os, json, sys

#argg = sys.argv[1]
#files = sys.argv[2]
#if argg == "-f":
# file

dslist=[]
dsdict={"data":None}
file = open('/usr/local/zabbix-agent/etc/zabbix_agentd.conf.d/list', 'r')
lines = file.readlines()
for line in lines:
  ddict={}
  line = line.strip('\n').split()
  ddict["{#MN_NAME}"] = line[0]
  ddict["{#MN_AOS}"] = line[1]
  ddict["{#MN_TAG}"] = line[2]
  ddict["{#MN_TAG1}"] = line[3]
  dslist.append(ddict)

dsdict["data"] = dslist

#print str(dsdict).decode('string_escape')
print json.dumps(dsdict, indent=4)
