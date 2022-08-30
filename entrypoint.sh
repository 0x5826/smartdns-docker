#!/bin/sh

if [ ! -d "/etc/smartdns" ]
then
    mkdir -p /etc/smartdns
    echo "[NOTICE] config dir inited."
fi

if [ ! -f "/etc/smartdns/smartdns.conf" ]
then
    cp /root/smartdns.conf /etc/smartdns
    echo "[NOTICE] smartdns.conf inited."
fi

if [ ! -f "/etc/smartdns/blacklist_full.conf" ]
then
    cp /root/blacklist_full.conf /etc/smartdns
    echo "[NOTICE] blacklist_full.conf inited."
fi

if [ ! -f "/etc/smartdns/whitelist_full.conf" ]
then
    cp /root/whitelist_full.conf /etc/smartdns
    echo "[NOTICE] whitelist_full.conf inited."
fi


/usr/bin/smartdns -f -x