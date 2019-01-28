#!/bin/bash

messages=`echo $3 | tr '\r\n' '\n'`

subject=`echo $2 | tr '\r\n' '\n'`

#echo "${messages}" | mail -s "${subject}" $1
/usr/local/bin/sendEmail -f leilinops@163.com -t $1 -o tls=no -s smtp.163.com -u "$subject" -xu leilinops@163.com -xp <授权码> -m "$messages"
