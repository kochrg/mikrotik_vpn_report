#!/bin/bash

# Edit PREFIX, EMAIL, REPORT_DAY variables with your own
# PREFIX: the prefix you use in your MikroTik config log
PREFIX=
# Email you want to send the report
FROMNAME=          # your name
EMAILFROM=         # your email
EMAILTO=           # dest email
# Day of month you want to send the report
REPORTDAY=

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)

# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

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

if [ "$day" -gt "$REPORTDAY" ]; then
    if [ "$month" -eq "12" ]; then
        year=date -d "$(date +%Y-%m-1) 1 year" +%-Y
    fi
    month=date -d "$(date +%Y-%m-1) 1 month" +%-m
fi

if ! test -d "./reports"; then
    mkdir $SCRIPTPATH/reports
fi

if ! test -d "$SCRIPTPATH/reports/$year"; then
    mkdir $SCRIPTPATH/reports/$year
fi

if ! test -d "$SCRIPTPATH/reports/$year/$month"; then
    mkdir $SCRIPTPATH/reports/$year/$month
fi

cat /var/log/syslog | grep $PREFIX | grep connected >> $SCRIPTPATH/reports/$year/$month/report.txt

sendday=date -d "$(date +%Y-%m-1) 1 day" +%+d

if [ "$sendday" -eq "$REPORTDAY" ]; then
    # Send report in email
    mail -s "VPN Access report" -a FROM:$FROMNAME\<$EMAILFROM\> $EMAILTO < $SCRIPTPATH/reports/$year/$month/report.txt
fi