#!/bin/sh
# Note: Install pfBlockerNG via System > Package Manager > Available Packages > pfBlockerNG-devel
# pfBlocker IP Block Counts
grep "$(date -v-1d "+%b %d" | sed 's/0//')" /var/log/pfblockerng/ip_block.log | cut -d',' -f16,17,18,19 | sort | uniq -c | sed 's/,/ /g' | { echo "Count IP-Address Feed Source Target" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'pfBlocker IP Block Counts'