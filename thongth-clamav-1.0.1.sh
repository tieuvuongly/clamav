#!/bin/bash


KNOWN_DISTRIBUTION="(Debian|Ubuntu|RedHat|CentOS)"
DISTRIBUTION=$(lsb_release -d 2>/dev/null | grep -Eo $KNOWN_DISTRIBUTION   grep -Eo $KNOWN_DISTRIBUTION /etc/issue 2>/dev/null  grep -Eo $KNOWN_DISTRIBUTION /etc/Eos-release 2>/dev/null  grep -m1 -Eo $KNOWN_DISTRIBUTION /etc/os-release 2>/dev/null  uname -s)

if [ -f "/usr/local/bin/clamdscan.sh" ]; then
    rm -rf /usr/local/bin/clamdscan.sh
    rm -rf /tmp/badfiles
    rm -rf /var/log/clamav
    echo "Done deleted old file clamav"
else
    echo "File does not exist, skipping"
fi

if telnet gitlab.vnpaycloud.vn 443  </dev/null | grep -q "Escape character is";   then
   cd /root/ && git clone --branch master https://gitlab.vnpaycloud.vn/lytm/lytm_install.git && cd /root/lytm_install/clamav
   mv ./clamdscan.sh /usr/local/bin/
   chmod +x /usr/local/bin/clamdscan.sh
   tar -xvf ./clamav-1.0.1.linux.x86_64.tar
else
    echo "Network connection to gitlab.vnpaycloud.vn failed"
    exit
fi


if [ -f /etc/debian_version -o "$DISTRIBUTION" == "Debian" -o "$DISTRIBUTION" == "Ubuntu" ]; then
   apt-get remove clamav clamav-daemon -y
   apt-get autoremove clamav clamav-daemon -y
   apt-get purge clamav clamav-daemon -y
   dpkg -i ./clamav-1.0.1/clamav-1.0.1.linux.x86_64.deb
   groupadd clamav && sudo useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav
   mkdir /tmp/badfiles

elif [ -f /etc/redhat-release -o "$DISTRIBUTION" == "RedHat" -o "$DISTRIBUTION" == "CentOS" ]; then
    yum remove clamav.x86_64 -y
    yum install ./clamav-1.0.1/clamav-1.0.1.linux.x86_64.rpm -y
    groupadd clamav && sudo useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav
    mkdir /tmp/badfiles
else
   echo "Error: OS not matach"
   exit 1
fi

cat > /etc/cron.d/clamav-scan <<"EOF"
0 4 * * * root /usr/local/bin/clamdscan.sh
EOF


ip_address=$(hostname -I | awk '{print $1}')

if [[ $ip_address == 10.2* ]]; then
    mv ./clamav-1.0.1/clamd.conf-hcm /usr/local/etc/clamd.conf
    mkdir /var/log/clamav
    touch /var/log/clamav/freshclam.log
    touch /var/log/clamav/clamav.log
    /usr/local/bin/clamdscan.sh
    rm -rf ./clamav-1.0.1/
    rm -rf ~/lytm_install
    cd /root/
    clamdscan -V
    echo 'Done'
elif [[ $ip_address == 10.16* ]]; then
    mv ./clamav-1.0.1/clamd.conf-hni /usr/local/etc/clamd.conf
    mkdir /var/log/clamav
    touch /var/log/clamav/freshclam.log
    touch /var/log/clamav/clamav.log
    /usr/local/bin/clamdscan.sh
    rm -rf ./clamav-1.0.1/
    rm -rf ~/lytm_install
    cd /root/
    clamdscan -V
    echo 'Done'
else
   echo "Error: IP address $ip_address does not match required pattern"
   exit 1
fi
