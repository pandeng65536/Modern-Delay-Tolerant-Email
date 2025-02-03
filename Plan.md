# Plan

## November

Read articles:

- [Delay/Disruption Tolerant Networking (dtn)](https://datatracker.ietf.org/wg/dtn/documents/)
- [RFC 9171 - Bundle Protocol Version 7](https://datatracker.ietf.org/doc/rfc9171/)

## December

Read articles:

- [RFC 4838 - Delay-Tolerant Networking Architecture](https://datatracker.ietf.org/doc/html/rfc4838)
- [RFC 5598: Internet Mail Architecture](https://www.rfc-editor.org/rfc/rfc5598)
- read about email incl. 2 factor auth, anti spam techniques
- postfix/dovecot
  [How To Set Up a Postfix E-Mail Server with Dovecot | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-postfix-e-mail-server-with-dovecot)

## January

Set up Virtual Machine.

## February

Set up an email server, and an email client.

## March

Send and receive email between two clients. Incorporate security technologies into the email network.

## April

(Final Test)

## May

Set up a DTN, and incorporate email system into it.

Experimental testing.

## June

Design and implement a new delay-tolerant email system.

## July

Finalizing the dissertation.

```mermaid

gantt
    title Modern Delay-Tolerant Email
    dateFormat  YYYY-MM-DD
    section Background Research
    RFC 9171            :done, rfc9171, 2024-11-01, 2024-11-30
    RFC 4838            :done, rfc4838, 2024-11-01, 2024-11-30
    RFC 5598            :active, rfc5598, 2024-12-01, 2024-12-31
    RFC 6238            :active, research, 2024-12-01, 2024-12-31
    RFC 7208            :active, research, 2024-12-01, 2024-12-31
    section Environment Setup
    Virtual Machine               :vm, 2025-01-01, 2025-01-31
    section Basic Email System
    Email Server, Client       :mailserver, 2025-02-01, 2025-02-28
    Security    :security, 2025-03-01, 2025-03-31
    section DTN Integration
    Set up DTN  :dtsetup, 2025-04-01, 2025-04-30
    Experimental Testing         :testing, 2025-05-01, 2025-05-15
    section DT Email System
    Design DT Email System   :design, 2025-05-01, 2025-05-31
    Implement DT Email System:implement, 2025-05-16, 2025-06-30
    Finalize Dissertation      :dissertation, 2025-07-01, 2025-07-03

```

