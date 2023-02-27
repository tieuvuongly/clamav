#!/bin/bash
DIR=/var/log/clamav/
if test -d "$DIR"; then
#get script scan 
rm -rf /usr/local/bin/clamdscan.sh
cp ./clamdscan.sh /usr/local/bin/
tar -xvf ./clamav-1.0.1.linux.x86_64.tar
chmod +x /usr/local/bin/clamdscan.sh
#Scheduler scan
a=$(shuf -i 0-6 -n1)
a1="0 $a * * *"
echo "$a1 root /usr/local/bin/clamdscan.sh" > /etc/cron.d/clamav-scan
cat /etc/cron.d/clamav-scan

echo '1. ubuntu 20.04
2. centos, RHEL
Hi, please choose the OS server to update: '
read word
if [ $word -eq 1 ];then
apt-get remove clamav clamav-daemon -y
apt-get autoremove clamav clamav-daemon -y
apt-get purge clamav clamav-daemon -y
dpkg -i ./clamav-1.0.1/clamav-1.0.1.linux.x86_64.deb
##
mkdir /var/log/clamav/ /var/lib/clamav
touch /var/log/clamav/clamav.log
touch /var/log/clamav/freshclam.log
groupadd clamav && sudo useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav
chown -R clamav:clamav /var/log/clamav/ /var/lib/clamav
#Create a directory containing virus files
mkdir /tmp/badfiles
echo 'Server ClamAV
1. Site HCM enter: clamav1: 10.2.34.32
2. Site HNI enter: clamav2: 10.16.34.32
please choose site (Ex: 1 or 2): '
read word2
if [ $word2 -eq 1 ];then
mv ./clamav-1.0.1/clamd.conf-hcm /usr/local/etc/clamd.conf
rm -rf ./clamav-1.0.1/
/usr/local/bin/clamdscan -V >> "/var/log/clamav/freshclam.log" 2>&1
/usr/local/bin/clamscan -V
echo 'Done'
else
if [ $word2 -eq 2 ];then
mv ./clamav-1.0.1/clamd.conf-hni /usr/local/etc/clamd.conf
rm -rf ./clamav-1.0.1/
/usr/local/bin/clamdscan -V >> "/var/log/clamav/freshclam.log" 2>&1
/usr/local/bin/clamscan -V
echo 'Done'
fi
fi
else
if [ $word -eq 2 ];then
yum remove clamav.x86_64 clamav-data.noarch clamav-devel.x86_64 clamav-filesystem.noarch clamav-lib.x86_64 clamav-update.x86_64 clamd.x86_64 -y
yum install ./clamav-1.0.1/clamav-1.0.1.linux.x86_64.rpm -y
##
mkdir /var/log/clamav/ /var/lib/clamav
touch /var/log/clamav/clamav.log
touch /var/log/clamav/freshclam.log
groupadd clamav && sudo useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav
chown -R clamav:clamav /var/log/clamav/ /var/lib/clamav
#Create a directory containing virus files
mkdir /tmp/badfiles
echo 'Server ClamAV
1. Site HCM enter: clamav1: 10.2.34.32
2. Site HNI enter: clamav2: 10.16.34.32
please choose site (Ex: 1 or 2): '
read word2
if [ $word2 -eq 1 ];then
mv ./clamav-1.0.1/clamd.conf-hcm /usr/local/etc/clamd.conf
rm -rf ./clamav-1.0.1/
/usr/local/bin/clamdscan -V >> "/var/log/clamav/freshclam.log" 2>&1
/usr/local/bin/clamscan -V
echo 'Done'
else
if [ $word2 -eq 2 ];then
mv ./clamav-1.0.1/clamd.conf-hni /usr/local/etc/clamd.conf
rm -rf ./clamav-1.0.1/
/usr/local/bin/clamdscan -V >> "/var/log/clamav/freshclam.log" 2>&1
/usr/local/bin/clamscan -V
echo 'Done'
fi
fi
else
echo 'the OS not yet choose or incorrect!!'
fi
fi
else
##
mkdir /var/log/clamav/ /var/lib/clamav
touch /var/log/clamav/clamav.log
touch /var/log/clamav/freshclam.log
groupadd clamav && sudo useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav
chown -R clamav:clamav /var/log/clamav/ /var/lib/clamav
#get script scan 
rm -rf /usr/local/bin/clamdscan.sh
cp ./clamdscan.sh /usr/local/bin/
tar -xvf ./clamav-1.0.1.linux.x86_64.tar
chmod +x /usr/local/bin/clamdscan.sh
#Scheduler scan
a=$(shuf -i 0-6 -n1)
a1="0 $a * * *"
echo "$a1 root /usr/local/bin/clamdscan.sh" > /etc/cron.d/clamav-scan
cat /etc/cron.d/clamav-scan

echo '1. ubuntu 20.04
2. centos, RHEL
Hi, please choose the OS server to update: '
read word
if [ $word -eq 1 ];then
apt-get remove clamav clamav-daemon -y
apt-get autoremove clamav clamav-daemon -y
apt-get purge clamav clamav-daemon -y
dpkg -i ./clamav-1.0.1/clamav-1.0.1.linux.x86_64.deb
#Create a directory containing virus files
mkdir /tmp/badfiles
echo 'Server ClamAV
1. Site HCM enter: clamav1: 10.2.34.32
2. Site HNI enter: clamav2: 10.16.34.32
please choose site (Ex: 1 or 2): '
read word2
if [ $word2 -eq 1 ];then
mv ./clamav-1.0.1/clamd.conf-hcm /usr/local/etc/clamd.conf
rm -rf ./clamav-1.0.1/
/usr/local/bin/clamdscan -V >> "/var/log/clamav/freshclam.log" 2>&1
/usr/local/bin/clamscan -V
echo 'Done'
else
if [ $word2 -eq 2 ];then
mv ./clamav-1.0.1/clamd.conf-hni /usr/local/etc/clamd.conf
rm -rf ./clamav-1.0.1/
/usr/local/bin/clamdscan -V >> "/var/log/clamav/freshclam.log" 2>&1
/usr/local/bin/clamscan -V
echo 'Done'
fi
fi
else
if [ $word -eq 2 ];then
yum remove clamav.x86_64 clamav-data.noarch clamav-devel.x86_64 clamav-filesystem.noarch clamav-lib.x86_64 clamav-update.x86_64 clamd.x86_64 -y
yum install ./clamav-1.0.1/clamav-1.0.1.linux.x86_64.rpm -y
#Create a directory containing virus files
mkdir /tmp/badfiles
echo 'Server ClamAV
1. Site HCM enter: clamav1: 10.2.34.32
2. Site HNI enter: clamav2: 10.16.34.32
please choose site (Ex: 1 or 2): '
read word2
if [ $word2 -eq 1 ];then
mv ./clamav-1.0.1/clamd.conf-hcm /usr/local/etc/clamd.conf
rm -rf ./clamav-1.0.1/
/usr/local/bin/clamdscan -V >> "/var/log/clamav/freshclam.log" 2>&1
/usr/local/bin/clamscan -V
echo 'Done'
else
if [ $word2 -eq 2 ];then
mv ./clamav-1.0.1/clamd.conf-hni /usr/local/etc/clamd.conf
rm -rf ./clamav-1.0.1/
/usr/local/bin/clamdscan -V >> "/var/log/clamav/freshclam.log" 2>&1
/usr/local/bin/clamscan -V
echo 'Done'
fi
fi
else
echo 'the OS not yet choose or incorrect!!'
fi
fi
fi
