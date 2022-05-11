#!/bin/bash

# base dir
cd /app

# start the cups daemon
exec /usr/sbin/cupsd -f&

echo "waiting for cups to start"
while [ "$(nc -z 127.0.0.1 631; echo $?)" -gt 0 ] ; do
	echo "."
	sleep 0.01
done

#echo "Connecting to: ${IPP_IP}"
#connection_name="ipp"
#lpadmin -p ipp -E -v ipp://${IPP_IP}/ipp/print -m everywhere
#cupsenable $connection_name
#cupsaccept $connection_name
#lpoptions -d $connection_name
#lpstat -p -d
#lpstat -p

echo "*/10 * * * * /usr/bin/nmap -p 9100,515,631 ${NETWORKIPRANGE}/24 --open -oX - > /app/templates/printer.xml" > /etc/cron.d/nmap-cron	
chmod 0644 /etc/cron.d/nmap-cron && crontab /etc/cron.d/nmap-cron
service cron start

env FLASK_APP=server.py flask run --host=0.0.0.0 --port 5000
