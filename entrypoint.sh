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

if [ ! -f "$RULES_DIR/gfw.conf" ]
then
    cp /root/gfw.conf $RULES_DIR
    echo "[NOTICE] gfw.conf inited."
fi

/usr/bin/smartdns -f -x
