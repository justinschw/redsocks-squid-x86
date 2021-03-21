FROM alpine:3.12.1
LABEL maintainer="Justin Schwartzbeck"

# Set the working directory to /app
WORKDIR /app
# Copy the current directory contents into the container at /app

ENV PROXY_PORT=3128
RUN apk update
RUN apk add redsocks
RUN rm -rf /var/cache/apk/*

ENV PROXY_SERVER=localhost

COPY run.sh /app
COPY redsocks.conf /etc/redsocks.conf
RUN chmod +x /app/run.sh
RUN adduser -u 32 -D -H redsocks
RUN chown -R redsocks:redsocks /etc/redsocks.conf
RUN touch /var/log/redsocks.log
RUN chown -R redsocks:redsocks /var/log/redsocks.log

USER redsocks
ENTRYPOINT ["sh", "run.sh"]

