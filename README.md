This project allows you to automate the creation of a connection report
for MikroTik l2tp VPN server, and send it through email

First of all you need a linux remote log server
and then configure it to receive remote logs from the MikroTik VPN server

Installation and configuration steps:

1. Clone this project or download it to you remote log server
2. Open MikroTik Winbox and connect to the VPN server
3. Go to "System->Logging"
4. Go to "Actions" and create a "remote" conection log
5. In "Rules" add one with the "Topic = l2tp" and add a prefix,
   it will help you later to find the syslog registries in the
   remote server
6. Run install.sh
7. Edit the file vpn-report.sh

By default, the script executes at 9 p.m. everyday, you can change that with
H= and M= values in install.sh file

To see errors in cron execution go to the file /var/log/cron_reports.err
