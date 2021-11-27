#!  /bin/bash

source /etc/profile
source ~/.bash_profile

vpn_nic_name="vpn_cz-eth-1"
client_path="/root/vpnclient/"
vpn_name="cz-vpn-1"



#stop some  service  about softether client
dhclient $vpn_nic_name  -r
$client_path./vpnclient stop


#start some server about softether client
$client_path./vpnclient start
$client_path./vpncmd /CLIENT localhost /CMD accountconnect $vpn_name 
dhclient $vpn_nic_name
