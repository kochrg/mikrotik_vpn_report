#!/bin/bash
export PATH="/usr/local/bin:/usr/bin:/bin"

# Edit PREFIX, EMAIL, REPORT_DAY variables with your own
# PREFIX: the prefix you use in your MikroTik config log
PREFIX=
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

if [ "$day" -gt "$REPORTDAY" ]; then
    if [ "$month" -eq "12" ]; then
        year=$(date -d "$(date +%Y-%m-1) 1 year" +%-Y)
    fi
    month=$(date -d "$(date +%Y-%m-1) 1 month" +%-m)
fi

printf "# $(date) - SAVING DATA;\n" >> $SCRIPTPATH/reports/$year/$month/cronlog.txt
echo "$(cat /var/log/syslog | grep connected)" >> $SCRIPTPATH/reports/$year/$month/report.txt
printf "# $(date) - DATA SAVED;\n" >> $SCRIPTPATH/reports/$year/$month/cronlog.txt

# If tomorrow is the day to send the report -> then send the report
# use this if you send the report at night and don't want to include
# the REPORTDAY in the report
sendday=$(date --date="1 day" +%d)

# If you want to include the REPORTDAY in the report
# just comment the line sendday=$(date --date="1 day" +%d) before
# and uncomment the next line:
# sendday=$(date +%d)

if [ "$sendday" -eq "$REPORTDAY" ]; then
    # Send report in email
    printf "# $(date) - SENDING MAIL;\n" >> $SCRIPTPATH/reports/$year/$month/cronlog.txt
    mail -s "VPN Access report" -a FROM:$FROMNAME\<$EMAILFROM\> $EMAILTO < $SCRIPTPATH/reports/$year/$month/report.txt
    printf "# $(date) - MAIL SENT;\n" >> $SCRIPTPATH/reports/$year/$month/cronlog.txt
fi