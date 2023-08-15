
#! bin/bash

host_ip=`ifconfig -a | grep inet | grep -v  127* | grep -v 172* | grep -v inet6 | awk '{ print $2}'`
host_name=`cat  /etc/hostname`

#echo  "主机ip: "$host_ip
#echo  "主机名: "$host_name

echo "alter  host: "$host_ip" *******************"

sed -i "s/name: 10-188-19-1/name: $host_name/g"  /data/proxy.conf
sed -i "s/host: 10.188.19.1/host: $host_ip/g" /data/proxy.conf

sed -i "s/10.188.19.1/$host_ip/g" /data/config.yml
