#!/bin/sh
# Note: Install vnstat via System > Package Manager > Available Packages > Status_Traffic_Totals
# Traffic Totals
/usr/local/bin/vnstat -d -i em0 --style 3 | tail -9 | sed -e '8d' | sed 's/|//g' | sed 's/\([0-9]\) \([a-zA-Z]\)/\1\2/g' | { echo "Day RX TX Total Average" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'WAN Traffic Totals' && /usr/local/bin/vnstat -d -i em1 --style 3 | tail -9 | sed -e '8d' | sed 's/|//g' | sed 's/\([0-9]\) \([a-zA-Z]\)/\1\2/g' | { echo "Day RX TX Total Average" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'LAN Traffic Totals'
