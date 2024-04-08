#! /bin/sh
DATE=$(date +'%Y-%m-%d')
MEMOSFOLDER="/webdav/BaiduPan/apps/Memos"
MEMOSBKP=$MEMOSFOLDER/$DATE
ALISTFOLDER="/webdav/BaiduPan/apps/Alist"
ALISTBKP=$ALISTFOLDER/$DATE
# echo $ROOTBKP
cd $MEMOSFOLDER
mkdir $DATE
sleep 30s
docker cp memo:/var/opt/memos/memos_prod.db $MEMOSBKP
sleep 30s
docker cp memo:/var/opt/memos/memos_prod.db-shm $MEMOSBKP
sleep 30s
docker cp memo:/var/opt/memos/memos_prod.db-wal $MEMOSBKP
sleep 30s
#find /root/.memos/ -name "*.db*" -exec cp {} /home/BaiduPan/网站建设/Memos \;
cd /
cd $ALISTFOLDER
mkdir $DATE
sleep 30s
#docker cp alist:/opt/alist/data/config.json $ALISTBKP
cp /etc/alist/config.json $ALISTBKP
sleep 30s
#docker cp alist:/opt/alist/data/data.db-shm $ALISTBKP
cp /etc/alist/data.db-shm $ALISTBKP
sleep 30s
#docker cp alist:/opt/alist/data/data.db-wal $ALISTBKP
cp /etc/alist/data.db-wal $ALISTBKP
sleep 30s
