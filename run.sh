#!/bin/bash
echo "Configuration:"
echo "PROXY_SERVER=$PROXY_SERVER"
echo "PROXY_PORT=$PROXY_PORT"

cleanup() {
    iptables -t nat -D OUTPUT -m owner --uid-owner redsocks -j ACCEPT
    iptables -t nat -D OUTPUT  -p tcp --dport 80 -j REDIRECT --to-port 12345
    iptables -t nat -D OUTPUT  -p tcp --dport 443 -j REDIRECT --to-port 12345
}
trap cleanup INT TERM

cleanup

echo "Setting config variables"
sed -i "s/vPROXY-SERVER/$PROXY_SERVER/g" /etc/redsocks.conf
sed -i "s/vPROXY-PORT/$PROXY_PORT/g" /etc/redsocks.conf

echo "Starting redsocks and redirecting traffic via iptables"

/etc/init.d/redsocks restart

iptables -t nat -A OUTPUT -m owner --uid-owner redsocks -j ACCEPT
iptables -t nat -A OUTPUT  -p tcp --dport 80 -j REDIRECT --to-port 12345
iptables -t nat -A OUTPUT  -p tcp --dport 443 -j REDIRECT --to-port 12345

# wait indefinetely
while :; do
    sleep 1s
done
