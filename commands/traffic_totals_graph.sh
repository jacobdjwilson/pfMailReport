#!/bin/sh
# Note: Install vnstat via System > Package Manager > Available Packages > Status_Traffic_Totals
# Note: Output will look wrong until 7 days of traffic accumulates
# Note: This command sends data to external servers
# Traffic Totals Graph
json=$(/usr/local/bin/vnstat -d -i em0 --json d 7 | jq '.interfaces[0].traffic.day') && echo "<img src=\"https://quickchart.io/chart?width=500&height=300&c={type:'bar',data:{labels:[" && echo $json | jq '.[].date | "\(.month)/\(.day)"' | paste -sd, - | tr '"' "'" && echo "],datasets:[{label:'RX Gigs',data:[" && echo $json | jq '.[].rx' | awk '{print $1/1024/1024/1024}' | paste -sd, - && echo "]},{label:'TX Gigs',data:[" && echo $json | jq '.[].tx' | awk '{print $1/1024/1024/1024}' | paste -sd, - && echo "]}]}}\">"
