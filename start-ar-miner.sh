#!/bash/sh

NAME='arweave-miner-linux-v1.0.7.5'
#NAME='x-proxy-linux-amd64'
ProcessIDs=`ps -ef | grep "$NAME"  | grep -v "grep" | awk '{print $2}'`
#echo $ProcessIDs

if [ !$ProcessIDs ];then
  for id in  $ProcessIDs
     do 
        kill -9 $id        
        echo "killed  $id"
     done
fi

cd   /data
nohup   ./arweave-miner-linux-v1.0.7.5 >>  ar-miner-output.log &
