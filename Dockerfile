FROM alpine:latest

# Update SSL so that wget can read https sites
RUN apk update
RUN apk add ca-certificates wget && update-ca-certificates

# Install gotty
WORKDIR /tmp
RUN wget https://github.com/yudai/gotty/releases/download/v0.0.13/gotty_linux_amd64.tar.gz
RUN tar -zxvf gotty_linux_amd64.tar.gz
RUN mv gotty /usr/local/bin/gotty

# Install NGINX
RUN apk add nginx

EXPOSE 80
EXPOSE 8080

WORKDIR /var/www

# Suppose you have run.sh in the same directory as the Dockerfile
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]

LABEL metadata.launchbot.io="eyJQcm9qZWN0VGFnIjoiZ290dHkiLCJQcm9qZWN0TmFtZSI6IlRlcm1pbmFsIGFuZCBzdGF0aWMgc2VydmVyIiwiUHJvamVjdERlc2NyaXB0aW9uIjoiIiwiUHJvamVjdEhvbWVwYWdlIjoiIiwiUG9ydE1hcHBpbmdzIjpbeyJQb3J0IjoiODA4MCIsIkRlc2NyaXB0aW9uIjoiVGVybWluYWwifSx7IlBvcnQiOiI4MCIsIkRlc2NyaXB0aW9uIjoiV2ViIFNpdGUifV19"
