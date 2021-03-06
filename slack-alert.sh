#! /bin/bash
#author: james jia
#mail:   2568424253@qq.com 
#goal:   use slack webhook  alert  eth cluster
#date:   2021-12-13  start write  ping  check 


cz_proxy_ip="10.0.77.246"
cz_hub_gw_ip="192.168.3.254"

sh_hub_1_gw_ip="192.168.31.1"
vpn_ip_prefix="192.168."
ping_count=5     
ping_timeout_second=5
local_nic_name="eth0"
vpn_nic_name="vpn_cz-eth-1"
ip_alert_content_prefix="host: "
ip_alert_content_1=" get vpn server ip failed,please check!!!!"
ip_alert_content_2=" ping is unreachable,please check!!!"
ip_success_content_1=" cur host get ssl vpn  server dhcp ip is ok"
ip_success_content_2=" ping is ok."
alter_log_file="/tmp/slack_alter.log"

slack_webhook_token="https://hooks.slack.com/services/xxxxxxxxxxxxx/xxxxxxxxxxx/XXXXXXXXXXXXXXXXXXXXXXX"


source /etc/profile
source ~/.bash_profile





SendSlackMessage(){
  alertcontent=$@
  
  curl -X POST --data-urlencode  \
       "payload={  \
                 \"channel\": \"#alert-test\",  \
                 \"username\": \"webhookbot\",  \
                 \"text\": \"$alertcontent \"  \
                }" \
        $slack_webhook_token
}



CheckIpStatus(){
  hostlocalip=`ip addr | grep $local_nic_name | grep inet | awk '{print $2}' | cut -d \/ -f 1`
  hostvpnip=`ip addr | grep $vpn_nic_name | grep inet | awk '{print $2}' | cut -d \/ -f 1`
  #echo  "cur host get vpn ip is: "  $hostvpnip 

#check host is get ssl vpn ip
  if [ -z "$hostvpnip" ];then
     #echo "cur host can not get vpn ip from vpn server....."
     altercontent1="$ip_alert_content_prefix  $hostlocalip  \n  alert: to $cz_proxy_ip $ip_alert_content_1  \n time: `date`"
     echo  $altercontent1  > $alter_log_file
     SendSlackMessage   $altercontent1
  else 
     echo  "`date`: $ip_success_content_1"  > $alter_log_file
  fi
    
#check shanghai vpn sh_hub_1 gateway  send some ping      
  pingreceivecount1=`ping -c $ping_count $sh_hub_1_gw_ip -w $ping_timeout_second | grep loss | cut -d \, -f 2 | awk '{print $1}'`  
  #echo  “cur ping receive count：”   $pingreceivecount1
  if [ "$pingreceivecount1" = "0" ];then
     #echo "$sh_hub_1_gw_ip no reply, please send alert"  
     alterContent2="$ip_alert_content_prefix  $hostlocalip  \n  alert: to sh-hub-1 gw $sh_hub_1_gw_ip  $ip_alert_content_2 \n time: `date`"            
     echo   $alterContent2     >> $alter_log_file
     SendSlackMessage  $alterContent2   
  else
     echo "`date`: $hostlocalip to $sh_hub_1_gw_ip $ip_success_content_2" >> $alter_log_file
  fi

#check changzhou local  vpn server gateway ip send ping
  pingreceivecount2=`ping -c $ping_count $cz_hub_gw_ip -w $ping_timeout_second  | grep loss | cut -d \, -f 2 | awk '{print $1}'`  
  if [ "$pingreceivecount2" = "0" ];then  
     alterContent3="$ip_alert_content_prefix  $hostlocalip  \n  alert: to cz-hub gw $cz_hub_gw_ip  $ip_alert_content_2 \n time: `date`" 
     echo $alterContent3   >> $alter_log_file
     SendSlackMessage  $alterContent3
  else
     echo "`date`: $hostlocalip to $cz_hub_gw_ip $ip_success_content_2"  >> $alter_log_file
  fi

#check changzhou local  vpn server underlay ip send ping
  pingreceivecount3=`ping -c $ping_count $cz_proxy_ip -w $ping_timeout_second  | grep loss | cut -d \, -f 2 | awk '{print $1}'`
  if [ "$pingreceivecount3" = "0" ];then
     alterContent4="$ip_alert_content_prefix  $hostlocalip \n  alert: to cz-server  $cz_proxy_ip  $ip_alert_content_2 \n time: `date`"
     echo $alterContent4  >> $alter_log_file
     SendSlackMessage  $alterContent4
  else
     echo "`date`: $hostlocalip to $cz_proxy_ip  $ip_success_content_2" >> $alter_log_file
  fi

}


CheckIpStatus
