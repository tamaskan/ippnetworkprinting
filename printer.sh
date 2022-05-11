#!/bin/bash

if [ -f $2 ]; 
then
echo "File exist"
else
echo "File not exist"
fi

echo "Connecting to: $1 and printing file $2"
connection_name=$1
lpadmin -p $1 -E -v ipp://$1/ipp/print -m everywhere
cupsenable $connection_name
cupsaccept $connection_name
lpoptions -d $connection_name
lpstat -p -d


lp -d $1 $2