#!/bin/sh
# Note: Install pfBlockerNG via System > Package Manager > Available Packages > pfBlockerNG-devel
# pfBlocker Domain Block Counts
grep "$(date "+%b" | sed 's/0//')" /var/log/pfblockerng/dnsbl.log | cut -d',' -f3,4,7,9 | sort | uniq -c | sed 's/,/ /g' | { echo "Count Domain Victim Source Feed" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'pfBlocker Domain Block Counts'