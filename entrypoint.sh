#!/bin/sh

CONF_DIR="/etc/smartdns"
RULES_DIR="/etc/smartdns/rules"
RULES_LIST="china apple_cn google_cn gfwlist global"

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

for f in $RULES_LIST
do
    if [ ! -f "$RULES_DIR/$f.txt" ]
    then
        cp /root/$f.txt $RULES_DIR
        echo "[NOTICE] $RULES_DIR/$f.txt inited."
    fi
done

/usr/bin/smartdns -f -x
