#!/bin/bash

tc qdisc add dev eth0 root netem delay 500ms
tc qdisc add dev eth1 root netem delay 500ms
sysctl -w net.ipv4.ip_forward=1

tail -f /dev/null

