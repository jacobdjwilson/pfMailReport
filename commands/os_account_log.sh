#!/bin/sh
# OS Account Log
tail -10 /var/log/userlog | sed -e "s/ /,/g" | sed 's/\[\([^]]*\)\]/\\ \1 /g' | { echo "Date User:Command Message" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'OS Account Log' | sed -e "s/,/ /g"