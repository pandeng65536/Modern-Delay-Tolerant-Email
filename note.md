[邮件系统详解 - Exungsh💫 - 博客园](https://www.cnblogs.com/exungsh/p/15890891.html)

## 历史

互联网之前发明 ARPANET  Ray Tomlinson  @

## 协议

MUA的全称是Mail User Agent、email client

MTA的全称是Mail Transfer Agent

MDA的全称是Mail Delivery Agent

MSA是的全称是Mail Submission Agent

- IMAP使用143端口，经过SSL/TLS加密的IMAPS协议使用993端口。
- POP3使用110端口，经过SSL/TLS加密的POP3S协议使用995端口。
- SMTP使用25端口，经过SSL/TLS加密的SMTPS协议使用465端口。

STARTTLS可以在原有的端口上加密IMAP、POP3和SMTP协议，它们分别仍然使用143、110、25端口。

Dovecot把MDA称为LDA(Local Delivery Agent)

[电子邮件系统是如何运作的？ - Linux大神博客](https://www.linuxdashen.com/电子邮件系统是如何运作的？)

```drawio
graphConfig = {
    "source": "./.assets/Email.drawio"
}
```

```drawio
graphConfig = {
    "source": "./.assets/email-emulator.drawio"
}
```

```bash
#docker build -t mail-server .
#docker network create mail-network

#docker run -d --name mail1 --hostname mail1 --network mail-network -e HOSTNAME=mail1 -e DOMAIN=example.com mail-server

#docker run -d --name mail2 --hostname mail2 --network mail-network -e HOSTNAME=mail2 -e DOMAIN=example.com mail-server

docker compose up -d --build

docker exec -it mail1 bash
cat /var/log/mail.log
# Send email
docker exec -it mail1 bash
echo "Hello from mail1" | mail -s "Test Email" user1@mail.2.com

docker exec -it mail2 bash
cat /var/mail/user1

# Reply emial
echo "Reply from mail2" | mail -s "Test Reply" user1@mail.1.com

cat /var/mail/user1
cat /var/log/mail.log


docker compose down -v
```

tc ca thunderbird

```mermaid
sequenceDiagram
    participant C as Client (mail2)
    participant S as Server (mail1)

    %% 1. TCP 三次握手 %%
    note over C,S: 阶段 1: TCP 连接建立
    C->>S: SYN (请求连接)
    S->>C: SYN-ACK (服务器响应)
    C->>S: ACK (连接确认)
    note right of C: TCP 握手完成

    %% 2. SMTP EHLO %%
    note over C,S: 阶段 2: SMTP 初始化和能力协商
    S->>C: 220 mail1.com ESMTP Postfix (欢迎消息)
    C->>S: EHLO mail2.com
    S->>C: 250-mail1.com (EHLO 响应)<br/>250-PIPELINING<br/>250-SIZE ...<br/>250-STARTTLS<br/>250 DSN
    note right of C: EHLO 完成, 服务器宣告支持 STARTTLS

    %% 3. STARTTLS %%
    note over C,S: 阶段 3: 请求并开始 TLS 加密
    C->>S: STARTTLS
    S->>C: 220 2.0.0 Ready to start TLS
    note right of C: 服务器同意开始 TLS

    %% 4. TLS 握手 %%
    note over C,S: 阶段 4: TLS 握手 (建立加密通道)
    C->>S: ClientHello
    S->>C: ServerHello, Certificate, [ServerKeyExchange], ServerHelloDone
    C->>S: ClientKeyExchange, ChangeCipherSpec, EncryptedHandshakeMessage
    S->>C: ChangeCipherSpec, EncryptedHandshakeMessage
    note right of C: TLS 握手完成, 后续通信将被加密

    %% 5. 邮件事务命令 (加密通道内) %%
    note over C,S: 阶段 5: 邮件事务命令 (已加密)
    C->>S: MAIL FROM:<user1@mail2.com>
    S->>C: 250 2.1.0 Ok

    C->>S: RCPT TO:<user1@mail1.com>
    S->>C: 250 2.1.5 Ok
    note right of C: 发件人和收件人确认

    %% 6. 邮件数据传输 (加密通道内) %%
    note over C,S: 阶段 6: 邮件数据传输 (已加密)
    C->>S: DATA
    S->>C: 354 End data with <CR><LF>.<CR><LF>

    C->>S: Subject: Test Email<br/>...邮件内容...<br/>. (结束符)
    S->>C: 250 2.0.0 Ok: queued as XXXXX
    note right of C: 邮件内容传输完成并被服务器接收

    %% 7. 结束会话 (加密通道内) %%
    note over C,S: 阶段 7: 结束会话 (已加密)
    C->>S: QUIT
    S->>C: 221 2.0.0 Bye
    note right of C: SMTP 会话正常结束

```

