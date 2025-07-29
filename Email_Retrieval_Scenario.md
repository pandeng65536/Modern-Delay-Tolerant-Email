# Deep Space Email Retrieval Delay Performance Experiment

## Background
Johnson’s solution (draft-johnson-dtn-interplanetary-smtp) and the SMTP Gatewaying Across Delay Tolerant Networks project have reduced the impact of interplanetary delay and disruption on email delivery. They efficiently deliver SMTP emails via DTN to mailbox on other planets.
However, problems arise when users travel to another planet and want to check their emails: their messages are still delivered to their original planet’s mailbox, but the process of retrieving emails is still performed using the traditional TCP-based IMAP protocol. Syncing mail folders and confirming each message are still greatly affected by the high interplanetary latency.

## Scenario Description
First, 1,000 emails (Body: “Hello”) are sent to the mail-2 server on the Moon. It means the recipient on the Moon has already successfully received their emails on the lunar email server.
Later, the recipient travels to Earth and wants to check these emails there. So, the recipient uses the Thunderbird client on mail-3 to retrieve these new emails via the IMAP protocol.

I test different physical one-way network delays (0s/1s/2s/5s), and record the total time required to retrieve all emails (overall retrieval time). The results are shown in the following table.



| Body  | Number of emails | Delay  (one-way) | Overall retrieval time |
| ----- | ---------------- | ---------------- | ---------------------- |
| Hello | 1000             | 0 s              | 19 s                   |
| Hello | 1000             | 1 s              | 33 s                   |
| Hello | 1000             | 2 s              | 64 s                   |
| Hello | 1000             | 5 s              | 153 s                  |

## Findings
The overall retrieval time increases linearly with network delay. When the delay is 5 seconds, the email client becomes very sluggish and is almost unusable.
To improve the email retrieval experience in deep space, it is necessary to introduce a DTN retrieval agent or a batch synchronization mechanism during the email retrieval process.
