#!  /bin/bash

vpn_nic_name="cz-eth-1"
client_path="/root/vpnclient/"
vpn_name="cz-vpn-1"


$client_path./vpncmd /CLIENT localhost /CMD accountdisconnect $vpn_name
$client_path./vpncmd /CLIENT localhost /CMD accountdelete $vpn_name
$client_path./vpncmd /CLIENT localhost /CMD nicdelete $vpn_nic_name
$client_path./vpnclient stop

rm  -rf  /root/vpnclient
