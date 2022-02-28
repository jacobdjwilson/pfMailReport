#!/bin/sh
# Note: Install speedtest-cli via Diagnostics > Command Prompt > Execute Shell Command:
# pkg update ; pkg install -y $( pkg search speedtest-cli | awk '{ print $1 }' )
# Speed Test
/usr/local/bin/speedtest-cli --secure --simple | { echo "Attribute Value Units" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'Speed Test Results'
