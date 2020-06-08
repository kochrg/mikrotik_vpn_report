#!/bin/bash

# Edit PREFIX, EMAIL, REPORT_DAY variables with your own
# PREFIX: the prefix you use in your MikroTik config log
PREFIX=
# Email you want to send the report
FROM_NAME=          # your name
EMAIL_FROM=         # your email
EMAIL_TO=           # dest email
# Day of month you want to send the report
REPORT_DAY=

year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)

if [$day > $REPORT_DAY]; then
    if [$month == '12']; then
        year=(date -d "$(date +%Y-%m-1) 1 year" +%-Y)
    fi
    month=(date -d "$(date +%Y-%m-1) 1 month" +%-m)
fi

if ![ test -d "./reports"]; then
    mkdir ./reports
fi

if ![ test -d "./reports/$year" ]; then
    mkdir ./reports/$year
fi

if ! [ test -d "./reports/$year/$month" ]; then
    mkdir ./reports/$year/$month
fi

echo cat /var/log/syslog | grep $PREFIX | grep connected >> ./reports/$year/$month/report.txt

if [ $day == $REPORT_DAY ]; then
    # Send report in email
    mail -s "VPN Access report" -a FROM:$FROM_NAME\<$EMAIL_FROM\> $EMAIL_TO < ./reports/$year/$month/report.txt
fi