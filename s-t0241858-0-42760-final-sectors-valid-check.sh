#! bin/bash
# author  james
# date：  2022-04-18
# goal:   进行FIL扇区的迁移测试 


#get start sectid  and   end sectid
full_file_name=`basename $0`
#echo  $full_file_name
file_name=$(echo "$full_file_name" | cut -f 1 -d '.')
#echo  $file_name
start_sector_id=`echo $file_name | cut -d \- -f 3`
end_sector_id=`echo $file_name | cut -d \- -f 4`
#echo  $start_sector_id
#echo  $end_sector_id
sector_cache_size="74M"
invalid_count=0    #当前无效的扇区数量
valid_count=0      #当前有效的扇区数量 
show_count=0       
col=9    #当前筛选数据的列数
check_log=/tmp/$file_name.log  #当前要存储的日志文件位置
sector_sealed_dir="/data/sealed"
sector_mv_sealed_dir="/data/invalid_sealed"
sector_cache_dir="/data/cache"
sector_mv_cache_dir="/data/invalid_cache"


#clean exist log file
rm -rf  $check_log

#list all sector numbers in a txt  
cd  /data
rm   -rf    sealed_info.txt
ls -al /data/sealed  | cat > sealed_info.txt

#get cur sector id
for line  in  `cat  /data/sealed_info.txt`
do
    remainder=$(( $show_count % $col ))
    #通过余数判断    
    if [ $remainder = 1 ];then
       cur_sector_id=`echo $line | cut -d \- -f 3`      
       #echo 当前选中的扇区id为:   $cur_sector_id
       if [ $cur_sector_id -ge  $start_sector_id  -a $cur_sector_id -le  $end_sector_id   ];then
          echo "当前需要迁移的扇区id为: $cur_sector_id "
          mv  $sector_sealed_dir/$line   $sector_mv_sealed_dir/$line 
          mv  $sector_cache_dir/$line/*  $sector_mv_cache_dir/$line/         

          invalid_count=$(($invalid_count+1))
       else
          #echo "当前有效的扇区id为: $cur_sector_id"
          valid_count=$(($valid_count+1))         
       fi

    fi
    show_count=$(($show_count+1))  
done

echo  "当前已迁移的效扇区个数为:  $invalid_count"
echo  "当前总有效扇区个数为:  $valid_count"
