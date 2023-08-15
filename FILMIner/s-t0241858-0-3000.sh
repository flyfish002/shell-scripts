#! bin/bash
#get start sectid  and   end sectid
full_file_name=`basename $0`
#echo  $full_file_name
file_name=$(echo "$full_file_name" | cut -f 1 -d '.')
#echo  $file_name
start_sector_id=`echo $file_name | cut -d \- -f 3`
end_sector_id=`echo $file_name | cut -d \- -f 4`
#echo  $start_sector_id
#echo  $end_sector_id
sector_size="32G"
#get cur sector id
for line  in  `cat f0241858-sealed.dat`
do
  str=`echo $line|sed 's/[0-9]//g'`
  if [ ! -z $str   ];then
     line_name=`echo $line | cut -d \:  -f 1`
     #echo  $line_name
     if  [ "$line_name" = "s3" ];then
         cur_sector_id=`echo $line | cut -d \- -f 4`
         echo  "find  cur sector: $cur_sector_id"  
         if [ $cur_sector_id -ge  $start_sector_id  -a $cur_sector_id -le  $end_sector_id   ];then     
            sector_file_name=`echo $line | cut -d \/ -f 5`  
            if  test -e   /data/sealed/$sector_file_name
            then 
                #echo "/data/sealed/$sector_file_name is exsit"
                file_size=`ls -hl /data/sealed/$sector_file_name | awk '{print $5}'`
                if [ $file_size !=  $sector_size ];then
                   echo   "/data/sealed/$sector_file_name is $file_size  not  complete, getting  data......."
                   s3cmd --force get s3://f0241858-1/sealed/$sector_file_name  /data/sealed
                else
                   echo "/data/sealed/$sector_file_name is complete"  
                fi   
            else
                echo "/data/sealed/$sector_file_name is not exsit, is getting  data !!!!!!!!!"
                s3cmd get s3://f0241858-1/sealed/$sector_file_name /data/sealed
            fi
            #s3cmd   --skip-existing  get   s3://f0241858-1/sealed/$sector_file_name    /data/sealed 
         fi       
     fi
   fi   
done
