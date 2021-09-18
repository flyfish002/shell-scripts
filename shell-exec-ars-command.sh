#! bin/bash

servers="2 3 4 5 6 7 8 9 10"
for i in $servers
    do
       echo exec host 10.188.19."${i}""*********************"
       ssh  root@10.188.19."${i}" $1
    done
