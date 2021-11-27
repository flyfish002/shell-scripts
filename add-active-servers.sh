#!  /bin/bash
active_servers="/root/active-servers.txt"
ssh_port=22
time_out_usec=1000000

#clear all exsit servers
rm  -rf  $active_servers

#search all hosts   10.0.72.0-10.0.75-254
for ((i=72;i<=75;i++))
do
    for ((j=1;j<=254;j++))
    do
        cur_ip="10.0."$i"."$j""
        echo "当前ip是:" $cur_ip
        ssh_result=`/root/./tcping $cur_ip  $ssh_port -u $time_out_usec | grep open `
       #echo  "return value is:  $ssh_result" 
        if  [ -n "$ssh_result" ];then
            echo  "add $cur_ip to server list！"
            echo $cur_ip >> $active_servers
        fi
    done            
done
