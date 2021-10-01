#! bin/bash

ftp_dirs="
20200310
20210318
20210329
20210330
20210529
20210701
20210707
20210715
20210726
20210803
20210811
20210819
20210824
20210902
20210909
"

for  ftp_dir  in $ftp_dirs
do
   cd /data/$ftp_dir
   nohup  `wget -m -nd -np ftp://ftpuser:ftpuser@10.188.19.1/$ftp_dir/ >> /data/ftp-ar-output.log` &
done
