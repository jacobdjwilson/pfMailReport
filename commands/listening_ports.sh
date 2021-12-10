#!/bin/sh
# Listening Ports and Processes
sockstat -4l | awk '{print $1, $2, $6, $7}' | uniq | { cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -t 'Listening Ports and Processes'