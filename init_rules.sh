#!/bin/bash

foreign_list="https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/main/gfwlist2smartdns/blacklist_lite.conf"
domestic_list="https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/main/gfwlist2smartdns/whitelist_lite.conf"

# DNS Server head config
cat >tmp_foreign_head.conf<<EOF
# DNS Server
server-tls 1.1.1.1 -group foreign -exclude-default-group
server-tls 8.8.8.8 -group foreign -exclude-default-group
server-https https://cloudflare-dns.com/dns-query -group foreign -exclude-default-group 
server-https https://dns.google/dns-query -group foreign -exclude-default-group

# Poisoned IP
bogus-nxdomain 104.239.213.7
bogus-nxdomain 198.105.254.11
bogus-nxdomain 211.137.51.78

# Foreign List
EOF

cat >tmp_domestic_head.conf<<EOF
# DNS Server
server 119.29.29.29 -group domestic
server 114.114.114.114 -group domestic
server 223.5.5.5 -group domestic

# Domestic List
EOF

# Update SmartDNS List
wget $foreign_list -O tmp_foreign.conf
wget $domestic_list -O tmp_domestic.conf

cat tmp_foreign_head.conf tmp_foreign.conf > foreign.conf
cat tmp_domestic_head.conf tmp_domestic.conf > domestic.conf

rm -f tmp_*
