FROM debian:buster
LABEL maintainer="Justin Schwartzbeck"

# Set the working directory to /app
WORKDIR /app
# Copy the current directory contents into the container at /app

ENV PROXY_PORT=3128
RUN apt-get update
RUN apt-get upgrade -qy
RUN apt-get install iptables redsocks lynx -qy
ENV PROXY_SERVER=localhost
ADD . /app
COPY redsocks.conf /etc/redsocks.conf
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]

