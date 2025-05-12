FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    postfix \
    mailutils \
    rsyslog\
    iputils-ping \
    iptables \
    iproute2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 添加用户 mail1 和 mail2，启用 Maildir 格式
RUN useradd -m -s /bin/bash mail1 && \
    useradd -m -s /bin/bash mail2 && \
    mkdir -p /home/mail1/Maildir /home/mail2/Maildir && \
    chown -R mail1:mail1 /home/mail1/Maildir && \
    chown -R mail2:mail2 /home/mail2/Maildir

# 创建日志目录并设置权限
RUN mkdir -p /var/log/postfix /var/log/rsyslog && \
    touch /var/log/mail.log && \
    chmod 755 /var/log/mail.log



# 配置 rsyslog 来禁用 imklog 模块
RUN sed -i 's/module(load="imklog"/# module(load="imklog"/' /etc/rsyslog.conf

# 使用正确的启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
