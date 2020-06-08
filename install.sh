#!/bin/bash

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

if [ cat /etc/crontab | grep "vpn-report.sh" ]; then
    # Script is installed, uninstall?
    echo -n "Are you sure you want to uninstall? (yes/NO) "
    read decision
    if [ "$decision" == "yes" ]; then
        echo -n "Uninstalling..."
        sed -i "vpn-report.sh" /etc/crontab
    fi
else
    # Script is not installed, install?
    echo -n "Are you sure you want to install? (yes/NO) "
    read decision
    echo -n "Your decision: $decision"
    if [ "$decision" == "yes" ]; then
        cp ./vpn-report-sample.sh ./vpn-report.sh
        echo -n "Adding to crontab..."
        echo -e "0 21\t* * *\troot\tsh $SCRIPTPATH/vpn-report.sh" >> /etc/crontab
        echo -n "Remember to edit the file $SCRIPTPATH/vpn-report.sh for personal config."
    fi
fi

echo -n "DONE...."