#!/bin/bash

LOG="/samu/uptime-kuma-nfs/backup-script.log"
SOURCE="/samu/uptime-kuma/"
DEST="/samu/uptime-kuma-nfs/"
WEBHOOK="http://10.10.10.116:3001/api/push/UcJDW1MBsD"

TIME=$(date)

# Backup uptime kuma database
rsync -r $SOURCE $DEST >> $LOG
#rsync -r $SOURCE $DEST

echo "Backup succesful at: $TIME" >> $LOG

# Ping uptime kuma webhook to tell we did backup
curl -k -S -m 10 $WEBHOOK >> $LOG
echo "" >> $LOG
