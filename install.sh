#!/bin/bash

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)

# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

# Hour to execute the script
H=21

# Minutes
M=00

if cat /etc/crontab | grep "vpn-report.sh"; then
    # Script is installed, uninstall?
    echo -n "Uninstalling... "
    sed -i "vpn-report.sh" /etc/crontab
else
    # Script is not installed, install?
    echo -n "Installing... "
    cp ./vpn-report-sample.sh ./vpn-report.sh
    echo -n "Adding to crontab..."
    echo "$M $H\t* * *\troot\tsh $SCRIPTPATH/vpn-report.sh 1> /dev/null 2>/var/log/cron_report.err" >> /etc/crontab
    echo -n "Remember to edit $SCRIPTPATH/vpn-report.sh for personal config."
fi

echo -n "DONE...."