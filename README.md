
# 脚本/配置
### 自定义监控键值

`/usr/local/zabbix-agent/etc/zabbix_agentd.conf.d`目录下。
hb.conf：
```
UnsafeUserParameters=1
UserParameter=hb.discover,/usr/local/zabbix-agent/etc/zabbix_agentd.conf.d/hbdiscover.sh
UserParameter=hb.discover.bussys,/usr/local/zabbix-agent/etc/zabbix_agentd.conf.d/hbdiscover-bussys.sh
UserParameter=hb.data.onemap[*],/usr/local/zabbix-agent/etc/zabbix_agentd.conf.d/hbapi.sh onemap $1 $2
UserParameter=hb.data.bussys[*],/usr/local/zabbix-agent/etc/zabbix_agentd.conf.d/hbapi.sh bussys $1 $2
```

接口调用脚本：hbapi.sh
```bash
/usr/local/zabbix-agent/etc/zabbix_agentd.conf.d/hbapi.sh onemap asoco.hb.rain_drain_hour 88888880000018
```
说明：

- onemap：第一个参数，表示调用哪个接口onemap为环保一张图的；
- asoco.hb.rain_drain_hour ：第二个参数，表示metric；
- 88888880000018： 第三个参数，设备编号。

脚本返回结果两种情况：
- true：之前两小时表示有数据；
- false：之前两小时表示没数据。

### 自动发现规则

在zabbix server端调用自动发现键值，必须返回如下格式：
```
{
    "data": [
        {
          "{#METRIC}":"asoco.hb.rain_drain_hour",
          "{#MD}":"88888880000012",
          "{#STATION}":"雨水"
        },
        {
          "{#METRIC}":"asoco.hb.rain_drain_hour",
          "{#MD}":"88888880000013",
          "{#STATION}":"雨水"
        },
        {
          "{#METRIC}":"asoco.hb.rain_drain_hour",
          "{#MD}":"88888880000015",
          "{#STATION}":"雨水"
        },
        {
          "{#METRIC}":"asoco.hb.rain_drain_hour",
          "{#MD}":"88888880000018",
          "{#STATION}":"雨水"
        }
        ]
}
```
在zabbix-server上使用命令验证：
```
zabbix_get -s 192.168.10.183 -p 10050 -k 'hb.discover'
```
返回如上格式数据为正确。
# zabbix界面配置
### 模板中创建自动发现规则

![](https://i.loli.net/2019/03/18/5c8f293ed0495.png)

-    创建模板，配置自动发现。
-   自动发现键值为“hb.discover”。

### 创建监控项原型

![](https://i.loli.net/2019/03/18/5c8f296ceeaa5.png)
 -   名称确保不会重复；
 -  其中键值为提前定义好的监控脚本；
 -  {#METRIC}和{#MD}为自动发现规则中的key值。

### 创建触发器

![](https://i.loli.net/2019/03/18/5c8f29b98f0f1.png)

- 表达式：字段中出现false则报警。
