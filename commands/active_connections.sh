#!/bin/sh
# Active Network Connections
pftop | tail -n+5 | awk '{print $4}' |  cut -f1 -d":" | uniq | whois `xargs` | awk '/CIDR/ ||  /NetName/ || /Organization/{print}' | awk '{print $2}' | sed 'N;N;s/\n/ /g' | sort | uniq | { echo "CIDR Network-Name Organization" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'Active Network Connections' | sed -e "s/,//g"