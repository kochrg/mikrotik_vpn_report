This project allows you to automate the creation of a connection report
for MikroTik l2tp VPN server, and send it through email

First of all you need a linux remote log server configured
to receive remote logs from the MikroTik VPN server

Installation and configuration:

1. Clone this project or download it to you remote log server
2. Open MikroTik Winbox and connect to the VPN server
3. Go to "System->Logging"
4. Go to "Actions" and create a "remote" conection log
5. In "Rules" add one with the "Topic = l2tp" and add a prefix,
   it will help you later to find the syslog registries in the
   remote server
6. Configure install.sh parameters
7. Run install.sh
8. Edit the file backup-vpn-report.sh
9. Edit the file generate-vpn-report.sh

By default the script executes at 9 p.m. everyday on day 25th, you can change that with
H=, M= and REPORTDAY= values in install.sh file

To see errors in cron execution go to the file /var/log/cron_reports.err
