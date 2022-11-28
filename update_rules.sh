#!/bin/sh

BLACKLIST_FILE="blacklist_lite.conf"
WHITELIST_FILE="whitelist_lite.conf"
BLACKLIST_URL_CDN="https://cdn.jsdelivr.net/gh/hezhijie0327/GFWList2AGH@main/gfwlist2smartdns/blacklist_lite.conf"
WHITELIST_URL_CDN="https://cdn.jsdelivr.net/gh/hezhijie0327/GFWList2AGH@main/gfwlist2smartdns/whitelist_lite.conf"

wget -q $BLACKLIST_URL_CDN -O /tmp/$BLACKLIST_FILE
if [ $? -eq 0 ];then
    mv /tmp/$BLACKLIST_FILE /etc/smartdns/rules/$BLACKLIST_FILE
    echo "[NOTICE] update $BLACKLIST_FILE successfully!"
else
    rm -f /tmp/$BLACKLIST_FILE 
    echo "[ERROR] update geoip.dat failed! please check your network!"
fi

wget -q $WHITELIST_URL_CDN -O /tmp/$WHITELIST_FILE
if [ $? -eq 0 ];then
    mv /tmp/$WHITELIST_FILE /etc/smartdns/rules/$WHITELIST_FILE
    echo "[NOTICE] update $WHITELIST_FILE successfully!"
else
    rm -f /tmp/$WHITELIST_FILE
    echo "[ERROR] update $WHITELIST_FILE failed! please check your network!"
fi
