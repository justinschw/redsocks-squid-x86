# redsocks-squid-x86
A docker image to transparently proxy to squid on x86
This image is based on the tutorial found here:
I have adapted it for use with squid. It will automatically add iptables rules, and will remove them when you call "docker stop" on it.

## Command to start
```
docker run -d --network host --privileged -e PROXY_SERVER=127.0.0.1 -e PROXY_PORT=3128 --restart unless-stopped --name redsocks jusschwa/redsocks-squid-x86
```
