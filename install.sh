#!/bin/bash

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)

# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

# Hour to execute the script
H=21

# Minutes
M=0

if cat /etc/crontab | grep "vpn-report.sh"; then
    # Script is installed, uninstall?
    echo -n "Uninstalling... "
    sed -i "vpn-report.sh" /etc/crontab
else
    # Script is not installed, install?
    echo -n "Installing... "
    cp ./vpn-report-sample.sh ./vpn-report.sh
    echo -n "Adding to crontab..."
    echo -e "$M $H\t* * *\troot\tsh $SCRIPTPATH/vpn-report.sh" >> /etc/crontab
    echo -n "Remember to edit the file $SCRIPTPATH/vpn-report.sh for personal config."
fi

echo -n "DONE...."