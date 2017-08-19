#!/bin/bash
lanstatus=`cat /sys/class/net/eth0/carrier`

if [[ `cat /sys/class/net/wlan0/carrier 2>/dev/null` == 1 ]]
 then
  wlanstatus=1
 else
  wlanstatus=0
fi

if (($wlanstatus==1)) || (($lanstatus==1))
 then
  echo -n "External IP: "
  dig +short myip.opendns.com @resolver1.opendns.com
  echo -n "Internal IP: "
  hostname -I
else
 echo "No network connection..."
fi
