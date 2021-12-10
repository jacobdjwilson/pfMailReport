#!/bin/sh
# System Logs
tail -10 /var/log/auth.log | { echo "Authentication Log" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -r 'System Logs' && tail -10 /var/log/dhcpd.log| { echo "DHCP Log" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -r && tail -10 /var/log/nginx.log | { echo "Web Server Log" ; cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -r