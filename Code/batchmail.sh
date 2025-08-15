#!/bin/bash

for i in $(seq 1 1000); do
    subject="Test$(printf '%03d' "$i")"
    {
        echo "Subject: $subject"
        echo "To: user@mail-2.a.com"
        echo
        echo "Hello"
    } | /usr/sbin/sendmail -f "user@mail-1.a.com" -t

    echo "Sent $subject"
done