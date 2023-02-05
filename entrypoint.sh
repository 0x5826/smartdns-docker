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
    echo "# address /www.example.com/1.2.3.4" > $RULES_DIR/hosts.conf
    echo "[NOTICE] hosts.conf inited."
fi

if [ ! -f "$RULES_DIR/domestic.conf" ]
then
    cp /root/domestic.conf $RULES_DIR
    echo "[NOTICE] domestic.conf inited."
fi

if [ ! -f "$RULES_DIR/foreign.conf" ]
then
    cp /root/foreign.conf $RULES_DIR
    echo "[NOTICE] foreign.conf inited."
fi

/usr/bin/smartdns -f -x
