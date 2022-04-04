#!/bin/sh
# Note: Install speedtest-cli via Diagnostics > Command Prompt > Execute Shell Command:
# pkg update ; pkg install -y $( pkg search speedtest-cli | awk '{ print $1 }' )
# Speed Test
/usr/local/bin/speedtest-cli --secure --share | sed -e '1d;3d;4d;6d;8d' | { date ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -r 'Speed Test Results'
#
# If you're having trouble with the email sending before the speed test completes try this
# Services > CRON > Add
# /usr/local/bin/speedtest-cli --secure --share | sed -e '1d;3d;4d;6d;8d' > /tmp/speedtest.out
# Then change the email report to read from the tmp .out file
# cat /tmp/speedtest.out | { date ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -r 'Speed Test Results'
