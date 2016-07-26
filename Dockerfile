FROM alpine:latest

# Update SSL so that wget can read https sites
RUN apk update
RUN apk add ca-certificates wget && update-ca-certificates
RUN apk add curl jq

# Install gotty
WORKDIR /tmp
RUN wget https://github.com/yudai/gotty/releases/download/v0.0.13/gotty_linux_amd64.tar.gz && \
    tar -zxvf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/gotty

# Install a simple server that can publish a directory as a file
RUN wget https://github.com/odewahn/httpServe/releases/download/0.0.1/httpServe-linux-amd64 && \
    mv httpServe-linux-amd64 /usr/local/bin/httpServe


# Set permissions

RUN chmod +x /usr/local/bin/gotty
RUN chmod +x /usr/local/bin/httpServe

# Expose the gotty port and the httpServe ports
EXPOSE 8080
EXPOSE 3000

WORKDIR /usr/workdir

# Install and run the startup script
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]

LABEL metadata.launchbot.io="eyJQcm9qZWN0VGFnIjoidGVybWluYWwtc2VydmVyLXRlc3QiLCJQcm9qZWN0TmFtZSI6IlRlcm1pbmFsIHdpdGggc3RhdGljIGNvbnRlbnQgc2VydmVyIiwiUHJvamVjdERlc2NyaXB0aW9uIjoiVGhpcyBjYW4gc2VydmUgYSBzdGF0aWMgc2l0ZSBhbmQgYSB0ZXJtaW5hbCBzZXJ2ZXIuIiwiUHJvamVjdEhvbWVwYWdlIjoiIiwiUG9ydE1hcHBpbmdzIjpbeyJQb3J0IjoiODA4MCIsIkRlc2NyaXB0aW9uIjoiQmFzaCBzaGVsbCJ9LHsiUG9ydCI6IjMwMDAiLCJEZXNjcmlwdGlvbiI6IlR1dG9yaWFsIn1dfQ=="
