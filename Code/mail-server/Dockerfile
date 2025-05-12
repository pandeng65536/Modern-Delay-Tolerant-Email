FROM ubuntu:20.04

# Avoid waiting for input during interactive installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    postfix \
    dovecot-core \
    dovecot-imapd \
    mailutils \
    procps \
    nano \
    iputils-ping \
    net-tools \
    iproute2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add startup script
COPY start-mail-server.sh /start-mail-server.sh
RUN chmod +x /start-mail-server.sh

EXPOSE 25 143

CMD ["/start-mail-server.sh"]
