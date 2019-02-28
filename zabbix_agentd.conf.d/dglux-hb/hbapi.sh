#!/bin/bash
METRIC=$2
MD=$3
START=$(date +%Y/%m/%d-%T -d "-2 hour")
END=$(date +%Y/%m/%d-%T)

onemap () {
curl -s http://xxx.xxx.com/api/dse/tsdb/environmental/oneMap/monitorData\?Metric\=$METRIC\&start\=$START\&end\=$END\&md\=$MD\&mp\=\* |jq '.content[0]|has ("metric")'
}

bussys () {
curl -s http://xxx.xxx.com/api/dse/tsdb/environmental/businessSystem/monitorData\?Metric\=$METRIC\&start\=$START\&end\=$END\&mn\=$MD\&mp\=\* |jq '.content[0]|has ("metric")'
}

case $1 in
        onemap)
                onemap
        ;;
        bussys)
                bussys
        ;;
        *)
                exit 1
        ;;
esac
