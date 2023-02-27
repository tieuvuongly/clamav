#!/bin/bash
LOGFILE="/var/log/clamav/clamav.log";
LOGFILE2="/var/log/clamav/freshclam.log";
DIRTOSCAN="/";
MOVETODIR="/tmp/badfiles/";
TODAY=$(date +%u);
/usr/local/bin/clamdscan -V >> "${LOGFILE2}" 2>&1
if [ "$TODAY" == "5" ];then
    DIRSIZE=$(du -shc $DIRTOSCAN 2>/dev/null| cut -f1 | tail -1)
    echo -e "Starting a full weekend scan of ${DIRTOSCAN} directory.\nAmount of data to be scanned is ${DIRSIZE}.";
    nice -n19 sudo /usr/local/bin/clamdscan -mi $DIRTOSCAN --move=$MOVETODIR &>"${LOGFILE}"
fi
# get the value of "Infected lines"
MALWARE=$(tail "${LOGFILE}"|grep Infected|cut -d" " -f3);
echo "The script has finished.";
exit 0;
