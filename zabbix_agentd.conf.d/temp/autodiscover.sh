#!/bin/bash
# 当前目录下java.txt文件用每列用空格隔开，"#"开头的行为注释不打印。
jmx_port_discovery () {

# 分割文件字段
Tomcat_Name=($(cat ./java.txt|grep -v "^#"|cut -d " " -f1))
jmx_port=($(cat ./java.txt|grep -v "^#"|cut -d " " -f2))
Tomcat_Name1=($(cat ./java.txt|grep -v "^#"|cut -d " " -f3))

# 起始行
printf '{\n'
printf '\t"data":[\n'

# 循环体
for((i=0;i<${#jmx_port[@]};++i))
{
num=$(echo $((${#jmx_port[@]}-1)))
if [ "$i" != ${num} ];then
printf "\t\t{ \n"
printf "\t\t\t\"{#JMX_PORT}\":\"${jmx_port[$i]}\",\n"
printf "\t\t\t\"{#JAVA_NAME}\":\"${Tomcat_Name[$i]}\",\n"
printf "\t\t\t\"{#JAVA_MN}\":\"${Tomcat_Name1[$i]}\"\n"
printf "\t\t},\n"

else
printf "\t\t{ \n"
printf "\t\t \n"
printf "\t\t\t\"{#JMX_PORT}\":\"${jmx_port[$i]}\",\n"
printf "\t\t\t\"{#JAVA_NAME}\":\"${Tomcat_Name[$i]}\",\n"
printf "\t\t\t\"{#JAVA_MN}\":\"${Tomcat_Name1[$i]}\"\n"
printf "\t\t}\n"

# 结束行
printf "\t]\n}\n"
fi
}
}
case "$1" in
jmx)
jmx_port_discovery
;;
*)
echo "Usage:$0 jmx"
;;
esac
