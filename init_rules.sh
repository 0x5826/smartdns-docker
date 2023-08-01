#!/bin/sh

# 1:GFW List
curl -sS https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt | \
    base64 -d | sort -u | sed '/^$\|@@/d'| sed 's#!.\+##; s#|##g; s#@##g; s#http:\/\/##; s#https:\/\/##;' | \
    sed '/apple\.com/d; /sina\.cn/d; /sina\.com\.cn/d; /baidu\.com/d; /qq\.com/d' | \
    sed '/^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+$/d' | grep '^[0-9a-zA-Z\.-]\+$' | \
    grep '\.' | sed 's#^\.\+##' | sort -u > tmp_gfwlist1
curl -sS https://raw.githubusercontent.com/hq450/fancyss/master/rules/gfwlist.conf | \
    sed 's/ipset=\/\.//g; s/\/gfwlist//g; /^server/d' > tmp_gfwlist2
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt > tmp_gfwlist3

cat tmp_gfwlist1 tmp_gfwlist2 tmp_gfwlist3 | sort -u | sed 's/^\.*//g' > gfwlist.txt

# 2:China domain list
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt |  grep -v "full:\|regexp:" > china.txt

# 3:Apple CN domain list
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt | sed 's/full\://g' > apple_cn.txt

# 4:Google CN domain list
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/google-cn.txt | sed 's/full\://g' > google_cn.txt

# 5:Global domain list

curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt | grep -v "regexp:" | sed 's/full\://g' | sort -u > global.txt

# 6:Chatgpt domain list
curl -fsSLk 'https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Bing/Bing.list' | \
grep -v "#" | grep "DOMAIN" | awk -F ',' '{ print $2 }' > chatgpt.txt
curl -fsSLk 'https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/OpenAI/OpenAI.list' | \
grep -v "#" | grep "DOMAIN" | awk -F ',' '{ print $2 }' >> chatgpt.txt

# 7:Cryptocurrency domain list
curl -fsSLk 'https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Cryptocurrency/Cryptocurrency.list' | \
grep -v "#" | grep "DOMAIN" | awk -F ',' '{ print $2 }' > cryptocurrency.txt

rm -f tmp_*
