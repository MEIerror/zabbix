!/bin/bash

File="/usr/local/zabbix-agent/etc/zabbix_agentd.conf.d/hb.txt"
LINES=($(cat $File|wc -l))

hb_station_discovery () {
printf '{\n'
printf '\t"data":[\n'
cat $File|while read line
    do
LINES=$(( $LINES - 1 ))
if [ $LINES -ne 0 ];then
        l1=$(echo $line|awk '{print $1}')
        l2=$(echo $line|awk '{print $2}')
        l3=$(echo $line|awk '{print $3}')
                        printf "\t{\n\t  \"{#METRIC}\":\"$l1\",\n\t  \"{#MD}\":\"$l2\",\n\t  \"{#STATION}\":\"$l3\"\n\t},\n"
else
        l1=$(echo $line|awk '{print $1}')
        l2=$(echo $line|awk '{print $2}')
        l3=$(echo $line|awk '{print $3}')
                        printf "\t{\n\t  \"{#METRIC}\":\"$l1\",\n\t  \"{#MD}\":\"$l2\",\n\t  \"{#STATION}\":\"$l3\"\n\t}\n"
fi
    done
printf '\t]\n'
printf '}\n'
}

hb_station_discovery
