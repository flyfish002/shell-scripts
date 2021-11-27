#! /bin/bash

server_list="/root/active-servers.txt"
host_passwd="gHo738Za"

for  host  in  `cat $server_list`
do
   echo "exec host **************$host******************" 
   /usr/bin/expect<<-EOF
   set timeout 5
   #spawn   scp  /opt/softether/add-softether-account.sh  root@$host:/opt/softether/
   #spawn   ssh  $host    "sh /opt/softether/stop-softether-client.sh"
   spawn   ssh  $host    "sh /opt/softether/softether-client-check.sh"
   expect "password:"   { send "$host_passwd\n" }
   expect eof
EOF
