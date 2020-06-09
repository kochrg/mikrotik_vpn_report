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

case $day in
    01)
        day=1
        ;;
    02)
        day=2
        ;;
    03)
        day=3
        ;;
    04)
        day=4
        ;;
    05)
        day=5
        ;;
    06)
        day=6
        ;;
    07)
        day=7
        ;;
    08)
        day=8
        ;;
    09)
        day=9
        ;;
esac

case $month in
    01)
        month=1
        ;;
    02)
        month=2
        ;;
    03)
        month=3
        ;;
    04)
        month=4
        ;;
    05)
        month=5
        ;;
    06)
        month=6
        ;;
    07)
        month=7
        ;;
    08)
        month=8
        ;;
    09)
        month=9
        ;;
esac

if [ $day -gt $REPORT_DAY ]; then
    if [ $month == '12' ]; then
        year=date -d "$(date +%Y-%m-1) 1 year" +%-Y
    fi
    month=date -d "$(date +%Y-%m-1) 1 month" +%-m
fi

if [ ! test -d "./reports" ]; then
    mkdir ./reports
fi

if [ ! test -d "./reports/$year" ]; then
    mkdir ./reports/$year
fi

if [! test -d "./reports/$year/$month" ]; then
    mkdir ./reports/$year/$month
fi

echo cat /var/log/syslog | grep $PREFIX | grep connected >> ./reports/$year/$month/report.txt

if [ $day -eq $REPORT_DAY ]; then
    # Send report in email
    mail -s "VPN Access report" -a FROM:$FROM_NAME\<$EMAIL_FROM\> $EMAIL_TO < ./reports/$year/$month/report.txt
fi