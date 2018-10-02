#!/bin/bash

THIS_DIR=`dirname "$0"`
FILE_BASENAME=`basename "$0" .sh`
LOCK_FILE=$THIS_DIR/$FILE_BASENAME.lock

clear

echo "#########################################"
echo "# JBackup - JoseRobinson.com (c) 2012\t#"
echo "#########################################"
echo 

# Si el fichero de lock existe es por que ya se esta corriendo el proceso.
if [ -f $LOCK_FILE ]; 
then 
	echo "Backup already in progress."
	exit 1;
else
	echo "Starting backup."
	touch $LOCK_FILE
fi

echo 
	
for PATH_ITEM in `cat $THIS_DIR/$FILE_BASENAME.csv` 
do 
	SOURCE_PATH=`echo $PATH_ITEM | cut -d "," -f 1`
	TARGET_PATH=`echo $PATH_ITEM | cut -d "," -f 2`
	
	echo -n "• $SOURCE_PATH"
	rsync -ua --exclude="node_modules/" --exclude="vendor/" --delete $SOURCE_PATH $TARGET_PATH
	echo -e "\r✔ $SOURCE_PATH"
done;

# Then, the lock file is deleted.
rm $LOCK_FILE

echo 
echo "Backup finished."

exit 0
