#!/bin/bash

# 确保日志文件存在
touch /var/log/mail.log

# 启动服务
service rsyslog start
service postfix start

echo "Mail服务器已启动"

# 使用 mail.log 而不是 syslog
tail -f /var/log/mail.log


