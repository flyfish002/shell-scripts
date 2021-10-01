#! bin/bash

#for host in `cat /data/expect-servers.txt`
servers="
10.188.7.13
10.188.7.14
10.188.7.15
10.188.7.16
10.188.7.17

10.188.8.12
10.188.8.13
10.188.8.14
10.188.8.15
10.188.8.16
10.188.8.17

10.188.18.9
10.188.18.10
10.188.18.11
10.188.18.12
10.188.18.13
10.188.18.14

10.188.19.11
10.188.19.12
10.188.19.13
10.188.19.14
10.188.19.15
"

#for host in $servers
#do
#    echo "exec******" $host "***********"
#   scp /data/x-proxy-linux-amd64   $host:/data/
#   scp /data/arweave-miner-linux-v1.0.7.5   $host:/data/
#   scp /data/config.yml     $host:/data/
#   scp /data/proxy.conf     $host:/data/
#   scp /data/start-miner.sh $host:/data/
#   scp /data/shell-Disable-HT.sh $host:/data/
#   scp  /data/stop-miner.sh  $host:/data/
#   scp /data/shell-all-ftp-data.sh   $host:/data
#    scp /data/restart-miner.sh  $host:/data
#done


server7xs="
10.188.7.13
10.188.7.14
10.188.7.15
10.188.7.16
10.188.7.17
"

server8xs="
10.188.8.1
10.188.8.2
10.188.8.3
10.188.8.4
10.188.8.5
"

server18xs="
10.188.18.9
10.188.18.10
10.188.18.11
10.188.18.12
10.188.18.13
10.188.18.14
"


server19xs="
10.188.19.11
10.188.19.12
10.188.19.13
10.188.19.14
10.188.19.15

"

for host1 in $server7xs
do
    echo "exec*******"$host1
    scp /data/shell-all-ftp-7x.sh   $host1:/data
done

for host2 in $server8xs
do
    echo "exec*******"$host2
    scp /data/shell-all-ftp-8x.sh   $host2:/data
done

for host3 in $server18xs
do
    echo "exec*******"$host3
    scp /data/shell-all-ftp-18x.sh   $host3:/data
done

for host4 in $server19xs
do
    echo "exec*******"$host4
    scp /data/shell-all-ftp-19x.sh   $host4:/data
done
