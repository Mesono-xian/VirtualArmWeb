#!/bin/sh
echo "Content-type: text/plain"
echo ""
/sbin/ifconfig eth0 | grep "inet addr" | awk -F':' '{print $2}' | awk '{print $1}'

