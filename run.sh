#!/bin/bash
echo "Configuration:"
echo "PROXY_SERVER=$PROXY_SERVER"
echo "PROXY_PORT=$PROXY_PORT"

echo "Starting redsocks and redirecting traffic via iptables"

redsocks -c /etc/redsocks.conf

# wait indefinetely
while :; do
    sleep 1s
done
