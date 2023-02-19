#!/bin/sh
# Step 1: Install nmap via System > Package Manager > Available Packages > nmap
#
# Note: This does not use pfMailReport, and instead requires a custom XSLT stylesheet
# Step 2: Install nmap-email.xsl via Diagnostics > Command Prompt > Execute Shell Command:
curl https://raw.githubusercontent.com/jacobdjwilson/nmap-email-xsl/main/nmap-email.xsl --output /tmp/nmap-email.xsl
#
# Step 3: Schedule a CRON job to perform the scan prior to the email report
# Services > CRON > Add 
# I suggest allocating 15+ minutes. Please change nmap flags for you use case
netstat -rn | grep -m 1 "em1" | awk '{print $1}' | xargs nmap -sS -T4 -A -sC -oX /tmp/nmap-scan.xml
#
# Step 4: Add the processing command to your scheduled email report
xsltproc /tmp/nmap-email.xsl /tmp/nmap-scan.xml
