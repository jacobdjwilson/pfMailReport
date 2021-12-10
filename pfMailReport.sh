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
section_header_background="#001d3b"
table_header_text="#fff"
table_header_background="#003366"
default_text="#000"
even_row_color="#ddd"
odd_row_color="#fff"
i=0 # global counter
#
echo \<h1' 'style=\"color\:$section_header_text\;background\-color\:$section_header_background\;text\-align\:left\;font\-size\:2em\;width\:100\%\"\>$2\<\/h1\>
while getopts ":trl" opt; do
  case ${opt} in
    t ) # input tabulated data into HTML table with columns
        echo \<table' 'class=\"table\"' 'style=\"width\:100\%\"\>
        echo \<thread\>
        while read line; do
            i=$(( i + 1 ))
            echo \<tr\>
            for item in $line; do
                if [ $i -lt 2 ]
                then
                echo \<th' 'scope=\"col\"' 'style=\"color\:$table_header_text\;background\-color\:$table_header_background\;text\-align\:left\;\"\>$item\<\/th\>
                else
                    if [ $((i%2)) -eq 0 ]
                    then
                        echo \<td' 'style=\"color\:$default_text\;background\-color\:$even_row_color\;text\-align\:left\;\"\>$item\<\/td\>
                    else
                        echo \<td' 'style=\"color\:$default_text\;background\-color\:$odd_row_color\;text\-align\:left\;\"\>$item\<\/td\>
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
        echo \<table' 'class=\"table\"' 'style=\"width\:100\%\"\>
        echo \<thread\>
        while read -r line; do
            i=$(( i + 1 ))
            echo \<tr\>
                if [ $i -lt 2 ]
                then
                echo \<th' 'scope=\"col\"' 'style=\"color\:$table_header_text\;background\-color\:$table_header_background\;text\-align\:left\;\"\>$line\<\/th\>
                else
                    if [ $((i%2)) -eq 0 ]
                    then
                        echo \<td' 'style=\"color\:$default_text\;background\-color\:$even_row_color\;text\-align\:left\;\"\>$line\<\/td\>
                    else
                        echo \<td' 'style=\"color\:$default_text\;background\-color\:$odd_row_color\;text\-align\:left\;\"\>$line\<\/td\>
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
    l ) # input tabulated data into HTML ordered list
        echo \<ol' 'class=\"list\-group' 'list\-group\-numbered\"' 'style=\"width\:100\%\"\>
        while read -r line; do
            i=$(( i + 1 ))
                if [ $((i%2)) -eq 0 ]
                then
                    echo \<li' 'class=\"list\-group\-item\"' 'style=\"color\:$default_text\;background\-color\:$even_row_color\;text\-align\:left\;\"\>$line\<\/li\>
                else
                    echo \<li' 'class=\"list\-group\-item\"' 'style=\"color\:$default_text\;background\-color\:$odd_row_color\;text\-align\:left\;\"\>$line\<\/li\>
                fi
            echo \<\/ol\>
        done
    ;;
    \? ) echo "Usage: cmd [-t] table columns [-r] table rows [-l] ordered list"
    ;;
  esac
done
