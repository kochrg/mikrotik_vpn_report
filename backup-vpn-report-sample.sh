#!/bin/bash
export PATH="/usr/local/bin:/usr/bin:/bin"

# Email you want to send the report
FROMNAME=       # your name
EMAILFROM=      # your email
EMAILTO=        # dest email
# Day of month you want to send the report
REPORTDAY=

# Absolute path to this script.
SCRIPT=$(readlink -f $0)

# Absolute path this script is in.
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
    10)
        month=10
        ;;
    11)
        month=11
        ;;
    12)
        month=12
        ;;
esac

printf "# $(date) - SAVING DATA;\n" >> $SCRIPTPATH/backup_reports/$year/$month/cronlog.txt
echo "$(cp /var/log/syslog $SCRIPTPATH/backup_reports/$year/$month/$year-$month-$day-syslog)"
echo "$(cat /var/log/syslog | grep connected)" >> $SCRIPTPATH/backup_reports/$year/$month/$year-$month-$day-report.txt
printf "# $(date) - DATA SAVED;\n" >> $SCRIPTPATH/backup_reports/$year/$month/cronlog.txt
