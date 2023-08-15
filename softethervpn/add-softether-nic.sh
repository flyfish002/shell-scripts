#!  /bin/bash

source /etc/profile
source ~/.bash_profile

client_path="/root/vpnclient/"
vpn_name="cz-eth-1"
log="/tmp/softether-client.log"
cur_time=`date`

#check softether client is  exsit
if [ ! -d $client_path  ];then
   echo "$cur_time : softether client is not exsit,please make it first" >> $log             
   cd ~
   tar  -xvzf softether-vpnclient-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz
   cd   vpnclient
   make 
else
   echo "$cur_time : softether client is exist" >> $log
fi

#start  softether  vpn  client service 
$client_path./vpnclient start
echo "$cur_time : softether client is started"  >> $log

#create vpn nic
$client_path./vpncmd /CLIENT localhost /CMD niccreate  $vpn_name
