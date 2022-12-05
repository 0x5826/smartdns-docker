#!/bin/bash

# GFW List
curl -sS https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt | \
    base64 -d | sort -u | sed '/^$\|@@/d'| sed 's#!.\+##; s#|##g; s#@##g; s#http:\/\/##; s#https:\/\/##;' | \
    sed '/apple\.com/d; /sina\.cn/d; /sina\.com\.cn/d; /baidu\.com/d; /qq\.com/d' | \
    sed '/^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+$/d' | grep '^[0-9a-zA-Z\.-]\+$' | \
    grep '\.' | sed 's#^\.\+##' | sort -u > temp_gfwlist1

curl -sS https://raw.githubusercontent.com/hq450/fancyss/master/rules/gfwlist.conf | \
    sed 's/ipset=\/\.//g; s/\/gfwlist//g; /^server/d' > temp_gfwlist2

curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt > temp_gfwlist3

cat temp_gfwlist1 temp_gfwlist2 temp_gfwlist3 | sort -u | sed 's/^\.*//g' > temp_gfwlist

# DNS Server config
cat >temp_gfw_head.conf<<EOF
# DNS Server
server-tls 1.1.1.1 -group GFW -exclude-default-group
server-tls 8.8.8.8 -group GFW -exclude-default-group

# Poisoned IP
bogus-nxdomain 104.239.213.7
bogus-nxdomain 198.105.254.11
bogus-nxdomain 211.137.51.78

# GFW List
EOF

# Update SmartDNS GFW List
sed -i 's/^/nameserver \//' temp_gfwlist
sed -i 's/$/\/GFW/' temp_gfwlist
cat temp_gfw_head.conf temp_gfwlist > gfw.conf
rm -f temp_*