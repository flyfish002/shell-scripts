#! /bin/sh
cd  $1
servers="2 3 4 5 6 7 8 9 10"
for i in $servers
  do
    if test -f $file
    then
      for file in $1/*
        do
           echo  transfer $file "*******************"root@10.188.19."${i}"
           scp  $file  root@10.188.19."${i}":$file
        done
    fi
  done
