#!/bin/env python
#-*-coding:utf-8-*-
import urllib2
import base64
import json
import sys

#url="http://192.168.1.148:8022/downstream/Modbus-server/server/1200201807091175/data"
#url=sys.argv[1]

# url用户名密码
username = "zabbix"
password = "zabbix"

try:
 uri = sys.argv[1]
# 对包含中文的url进行转码
 url = "http://192.168.1.63:8030" + urllib2.quote(uri)
 request = urllib2.Request(url)
 base64string = base64.encodestring('%s:%s' % (username, password)).replace('\n', '')
 # base64加密登录
 request.add_header("Authorization", "Basic %s" % base64string)   
 result = urllib2.urlopen(request)

 # 将url内容转换成json格式，并获取其中的时间戳
 hjson = json.loads(result.read())
# timestamp = hjson['?value_timestamp']
 value = hjson['?value']

# if timestamp == "connect":
#  print 0
# else:
#  print 1
 print value
except:
 print 'invalid restapi'
