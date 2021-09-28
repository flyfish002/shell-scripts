#!/bash/sh

AR_MINER='arweave-miner-linux-v1.0.7.5'
AR_PROXY='x-proxy-linux-amd64'

ProxyIDs=`ps -ef | grep "$AR_PROXY"  | grep -v "grep" | awk '{print $2}'`
if [ !$ProxyIDs ];then
  for id1 in  $ProxyIDs
     do 
        kill -9 $id1        
        echo "killed proxy miner   $id1"
     done
fi

cd   /data
nohup   ./$AR_PROXY >> proxy-ar-output.log &




MinerIDs=`ps -ef | grep "$AR_MINER"  | grep -v "grep" | awk '{print $2}'`
if [ !$MinerIDs ];then
  for id2 in  $MinerIDs
     do 
        kill -9 $id2        
        echo "killed  miner  $id2"
     done
fi

cd   /data
nohup   ./$AR_MINER >>  ar-miner-output.log &



exit  0
