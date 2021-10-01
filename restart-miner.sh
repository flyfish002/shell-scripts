#!/bash/sh
AR_PROXY='x-proxy-linux-amd64'
AR_MINER='arweave-miner-linux-v1.0.7.5'

pkill -9 $AR_PROXY
cd   /data
#nohup   `./$AR_PROXY >> proxy-ar-output.log` &
nohup  ./x-proxy-linux-amd64 >> proxy-ar-output.log  &


pkill -9 arweave-miner-linux-v1.0.7.5
#nohup   `./$AR_MINER >>  ar-miner-output.log` &
nohup ./arweave-miner-linux-v1.0.7.5 >> ar-miner-output.log  &
