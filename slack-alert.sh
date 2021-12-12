#! /bin/bash

#author: james jia
#date:   2021-12-12
#goal:   user slack webhook  alert  eth cluster

curl -X POST --data-urlencode \
"payload={ \
\"channel\": \"#alert-test\", \
\"username\": \"webhookbot\", \
\"text\": \"注意，fil 集群有问题啦！\" \
}" \
https://hooks.slack.com/services/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



