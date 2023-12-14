#!/bin/bash

max_attempts=10
failed_threshold_attemps=5
failed_ping_attempts=0
failed_tcping_attempts=0
slack_webhook_token="https://hooks.slack.com/services/T069E0EMRC3/B0698TKQFBQ/XXXXXXXXXXXXXXXXXXXXXXX"
result_check_ok="探测成功，服务正常"
result_check_fail="探测失败，请派人查看!!!"


CheckTianBanJiStatus(){
while read col1 col2 col3 ; do
      clusterName=$col1
      jumpServerIP=$col2
      tianBanJiPort=$col3    

      for ((i=1; i<=$max_attempts; i++)); do
          echo 测试跳板机:  $clusterName   $jumpServerIP   $tianBanJiPort
          if !  CheckPortConnectivity "$jumpServerIP" "$tianBanJiPort"   ; then
             ((failed_tcping_attempts++))
          fi
      done


      if [ $failed_tcping_attempts -ge $failed_threshold_attemps ]
      then
          #echo "连续10次tcp端口测试，集群: $clusterName , 跳板机ip: $jumpServerIP , 跳板机端口: $tianBanJiPort ,10次探测中有5次以上失败，报错"
          alertMessage="集群: ${clusterName}  跳板机ip: ${jumpServerIP}   跳板机端口: ${tianBanJiPort}  "${result_check_fail}" "
          SendSlackMessage   "$alertMessage"
          
      else
          #echo "连续10次tcp端口测试，集群: $clusterName , 跳板机ip: $jumpServerIP , 跳板机端口: $tianBanJiPort ,失败次数未达到阈值，未报错"
          alertMessage="集群: ${clusterName}  跳板机ip: ${jumpServerIP}   跳板机端口: ${tianBanJiPort} "$result_check_ok"  "
          #SendSlackMessage   "$alertMessage"
      fi

done <   /root/smh-script/smh_storage_info.txt
}


CheckPortConnectivity() {
  nc -z -w 1 $1 $2 ;echo $? 
}


SendSlackMessage(){  
  local alertMessage=$1

  curl -X POST --data-urlencode  \
       "payload={  \
                 \"channel\": \"smh-jumpserver-alert\",  \
                 \"username\": \"webhookbot\",  \
                 \"text\": \"$alertMessage \"  \
                }" \
         $slack_webhook_token
}


CheckTianBanJiStatus
