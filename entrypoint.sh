#!/bin/sh

CONF_DIR="/etc/smartdns"
RULES_DIR="/etc/smartdns/rules"

if [ ! -f "$CONF_DIR/smartdns.conf" ]
then
    cp /root/smartdns.conf $CONF_DIR
    echo "[NOTICE] smartdns.conf inited."
fi

if [ ! -d "$RULES_DIR" ]
then
    mkdir -p $RULES_DIR
    echo "[NOTICE] $RULES_DIR inited."
fi

if [ ! -f "$RULES_DIR/hosts.conf" ]
then
    touch $RULES_DIR/hosts.conf
    echo "[NOTICE] hosts.conf inited."
fi

if [ ! -f "$RULES_DIR/blacklist_full.conf" ]
then
    cp /root/blacklist_full.conf $RULES_DIR
    echo "[NOTICE] blacklist_full.conf inited."
fi

if [ ! -f "$RULES_DIR/whitelist_full.conf" ]
then
    cp /root/whitelist_full.conf $RULES_DIR
    echo "[NOTICE] whitelist_full.conf inited."
fi

/usr/bin/smartdns -f -x
