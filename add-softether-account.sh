#!  /bin/bash

source /etc/profile
source ~/.bash_profile

account_name="cz-vpn-1"
vpn_name="cz-vpn-1"
vpn_nic_name="cz-eth-1"
server_name="10.0.73.128:443"
hub_name="cz-hub-1"
user_name="cz001"
user_passdwd="gHo738Za"


client_path="/root/vpnclient/"
log="/tmp/softether-client.log"
cur_time=`date`

#check cur vpn account is exist
account_content=`$client_path./vpncmd /CLIENT localhost /CMD accountlist | grep $account_name` 
#echo  $account_content

if [ -z "$account_content" ];then
   echo "$cur_time : $account_name is not exsit,you should create it."  >> $log 

#start create vpn account
   /usr/bin/expect<<-EOF
   set timeout 5
   spawn  $client_path./vpncmd /CLIENT localhost /CMD accountcreate $vpn_name
   expect "Host Name and Port Number:" { send "$server_name\n" }
   expect "Virtual Hub Name:"          { send "$hub_name\n" }
   expect "User Name:"                 { send "$user_name\n" }
   expect "Network Adapter Name:"      { send "$vpn_nic_name\n" }
   expect eof
EOF
else
   echo "$cur_time : $account_name is exsit"  >> $log
fi


#create acconut password
/usr/bin/expect<<-EOF
set timeout 5
spawn  $client_path./vpncmd /CLIENT localhost /CMD accountpasswordset $vpn_name
expect "Password:"           { send "$user_passdwd\n" }
expect "Confirm input:"      { send "$user_passdwd\n" }
expect "standard or radius:" { send "standard\n" }
expect eof
EOF
echo "$cur_time : accout password is set "  >> $log
