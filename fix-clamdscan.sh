#!/bin/bash
DIR=/var/log/clamav/
if test -d "$DIR"; then
#get script scan 
rm -rf /usr/local/bin/clamdscan.sh
cp ./clamdscan.sh /usr/local/bin/
chmod +x /usr/local/bin/clamdscan.sh
groupadd clamav && sudo useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav
#/usr/local/bin/clamdscan.sh 
cd && rm -rf lytm_install/
clamdscan -V
echo '1/Done'
else
mkdir /var/log/clamav/ /var/lib/clamav
touch /var/log/clamav/clamav.log
touch /var/log/clamav/freshclam.log
groupadd clamav && sudo useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav
chown -R clamav:clamav /var/log/clamav/ /var/lib/clamav
#get script scan 
rm -rf /usr/local/bin/clamdscan.sh
cp ./clamdscan.sh /usr/local/bin/
chmod +x /usr/local/bin/clamdscan.sh
#/usr/local/bin/clamdscan.sh 
clamdscan -V
cd && rm -rf lytm_install/
echo '2/Done'
fi
