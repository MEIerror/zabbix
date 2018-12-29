#!/bin/sh

usage () {
  echo "Usage: ding.sh [webhook] [cell-phone number] [messages]";
  echo "       [webhook]: 钉钉聊天机器人webhook。";
  echo "       [cell-phone number]: 要@的成员手机号。";
  echo "       [messages]: 发送的消息，支持Markdown语法,如：'# 标题一\n## 标题二\n - 序列一\n - 序列二\n'";
  exit 1;
}

if (($# != 3));then
	usage
fi		

WEB_HOOK=$1
AT=$2
shift 2


text(){
curl ${WEB_HOOK} -H "Content-type: application/json" -X POST -d "
{
      "msgtype": 'text',
      "text": {
          "content": '
$*
'
      },
      "at": {
          "atMobiles": [
              "$AT"
          ],
          "isAtAll": false
      }
}"
}

actioncard(){
curl ${WEB_HOOK} -H "Content-type: application/json" -X POST -d "
{
    "actionCard": {
        "title": 'title', 
         "text": 'text @18868321887',
        "hideAvatar": '0', 
        "btnOrientation": '0', 
        "singleTitle" : '错误地址',
        "singleURL" : 'http://192.168.1.116/lng/lng-microservice/pipelines'
    }, 
    "msgtype": 'actionCard',
      "at": {
          "atMobiles": [
              "18868321887"
          ],
          "isAtAll": false
      }
}"
}

markdown(){
curl ${WEB_HOOK} -H "Content-type: application/json" -X POST -d "
{
     "msgtype": 'markdown',
     "markdown": {
     "title":'监控报警',
     "text":'
$*

@${AT}
'

     },
      "at": {
          "atMobiles": [
              "$AT"
          ],
          "isAtAll": false
      }

}"

}







#actioncard   
#text $@
markdown $@
