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

/usr/sbin/smartdns -f -x