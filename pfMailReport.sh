#!/bin/sh
#
# pfMailReport.sh
# Copyright (c) 2021 Jacob Wilson <jacobdjwilson@gmail.com>
# All rights reserved.
# 
# design for use with pfSense 2.5 (https://www.pfsense.org)
# Copyright (c) 2011-2021 Rubicon Communications, LLC (Netgate)
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
section_header_text="#fff"
section_header_background="#000842"
table_header_text="#fff"
table_header_background="#003366"
default_text="#000"
even_row_color="#ddd"
odd_row_color="#fff"
font_type="Arial"
font_size="16px"
line_height="24px"
line_margins="3px 0 3px 0"
#
help() {
cat << EOF
Usage: cmd [-t] table columns [-r] table rows [-l] unordered list 'Section Header'

pfMailReport wraps pfSense command output into a rich format HTML
suitable for email via the mailreport package. Currently this project
supports pfSense version 2.5.x, users can install this package and
script through the WebUI.

    -c (optional)  Comma Seperated Value data structure input
    -p (optional)  JSON Key Value Ppair data structure input
    -t Table       Format tabulated data into HTML table with columns
    -r Rows        Format tabulated data into HTML table with rows
    -l List        Format tabulated data into HTML unordered list

Simple Example:
cat /var/log/auth.log | sh /usr/local/bin/pfMailReport.sh -l 'Authentication Log'

Comma Seperated Value Example:
tail /var/log/pfblockerng/dnsbl.log | { cat ; echo ; } | sh /usr/local/bin/pfMailReport.sh -ct
EOF
}
i=0 # global counter
if [ -n "$1" ]; then
  if [ -n "$2" ]; then
    echo \<h1' 'style=\"color\:$section_header_text\;background\-color\:$section_header_background\;text\-align\:left\;font\-size\:2em\;width\:100\%\;font\-family\:$font_type\;\"\>$2\<\/h1\>
  fi
else
  echo "pfMailReport requires input from other commands. Try something like... echo log_file.log | sh /usr/local/bin/pfMailReport.sh -r 'Log Name' "
fi
while getopts ":cptrl" opt; do
  case ${opt} in
    t ) # input tabulated data into HTML table with columns
        echo \<table' 'class=\"table\"' 'role\=\"presentation\"' 'style=\"width\:100\%\;border\-collapse\:collapse\;border\:0\;border\-spacing\:0\;\"\>
        echo \<thread\>
        while read line; do
            i=$(( i + 1 ))
            echo \<tr\>
            for item in $line; do
                if [ $i -lt 2 ]
                then
                echo \<th' 'scope=\"col\"' 'style=\"color\:$table_header_text\;background\-color\:$table_header_background\;text\-align\:left\;\"\>\<p' 'style\=\"margin\:$line_margins\;font\-size\:$font_size\;line\-height\:$line_height\;font\-family\:$font_type\;\"\>$item\<\/p\>\<\/th\>
                else
                    if [ $((i%2)) -eq 0 ]
                    then
                        echo \<td' 'style=\"color\:$default_text\;background\-color\:$even_row_color\;text\-align\:left\;\"\>\<p' 'style\=\"margin\:$line_margins\;font\-size\:$font_size\;line\-height\:$line_height\;font\-family\:$font_type\;\"\>$item\<\/p\>\<\/td\>
                    else
                        echo \<td' 'style=\"color\:$default_text\;background\-color\:$odd_row_color\;text\-align\:left\;\"\>\<p' 'style\=\"margin\:$line_margins\;font\-size\:$font_size\;line\-height\:$line_height\;font\-family\:$font_type\;\"\>$item\<\/p\>\<\/td\>
                    fi
                fi
            done
            if [ $i -lt 2 ]
            then
                echo \<\/thread\>
                echo \<tbody\>
            fi
            echo \<\/tr\>
        done
        echo \<\/tbody\>
        echo \<\/table\>
    ;;
    r ) # input tabulated data into HTML table with rows
        echo \<table' 'class=\"table\"' 'role\=\"presentation\"' 'style=\"width\:100\%\;border\-collapse\:collapse\;border\:0\;border\-spacing\:0\;\"\>
        echo \<thread\>
        while read -r line; do
            i=$(( i + 1 ))
            echo \<tr\>
                if [ $i -lt 2 ]
                then
                echo \<th' 'scope=\"col\"' 'style=\"color\:$table_header_text\;background\-color\:$table_header_background\;text\-align\:left\;\"\>\<p' 'style\=\"margin\:$line_margins\;font\-size\:$font_size\;line\-height\:$line_height\;font\-family\:$font_type\;\"\>$line\<\/th\>
                else
                    if [ $((i%2)) -eq 0 ]
                    then
                        echo \<td' 'style=\"color\:$default_text\;background\-color\:$even_row_color\;text\-align\:left\;padding\:0\;vertical\-align\:top\;\"\>\<p' 'style\=\"margin\:$line_margins\;font\-size\:$font_size\;line\-height\:$line_height\;font\-family\:$font_type\;\"\>$line\<\/p\>\<\/td\>
                    else
                        echo \<td' 'style=\"color\:$default_text\;background\-color\:$odd_row_color\;text\-align\:left\;padding\:0\;vertical\-align\:top\;\"\>\<p' 'style\=\"margin\:$line_margins\;font\-size\:$font_size\;line\-height\:$line_height\;font\-family\:$font_type\;\"\>$line\<\/p\>\<\/td\>
                    fi
                fi
            if [ $i -lt 2 ]
            then
                echo \<\/thread\>
                echo \<tbody\>
            fi
            echo \<\/tr\>
        done
        echo \<\/tbody\>
        echo \<\/table\>
    ;;
    l ) # input tabulated data into HTML unordered list
        echo \<l' 'class=\"list\-group' 'list\-group\-numbered\"' 'style=\"width\:100\%\; list\-style\-type\:none\;\"\>
        while read -r line; do
            i=$(( i + 1 ))
                if [ $((i%2)) -eq 0 ]
                then
                    echo \<li' 'class=\"list\-group\-item\"' 'style=\"color\:$default_text\;background\-color\:$even_row_color\;text\-align\:left\;\"\>\<p' 'style\=\"margin\:$line_margins\;font\-size\:$font_size\;line\-height\:$line_height\;font\-family\:$font_type\;\"\>$line\<\/p\>\<\/li\>
                else
                    echo \<li' 'class=\"list\-group\-item\"' 'style=\"color\:$default_text\;background\-color\:$odd_row_color\;text\-align\:left\;\"\>\<p' 'style\=\"margin\:$line_margins\;font\-size\:$font_size\;line\-height\:$line_height\;font\-family\:$font_type\;\"\>$line\<\/p\>\<\/li\>
                fi
        done
        echo \<\/ul\>
    ;;
    c ) # comma seperated value input
      var=$IFS
      IFS=','
    ;;
    p ) # json key value pair input
      var=$IFS
      IFS=':'
    ;;
    \? ) 
      help >&2
      exit 1
    ;;
    :)
      help >&2
      exit 1
    ;;
  esac
done
if [ -z ${var+x} ]; then exit; else IFS=$var; fi
