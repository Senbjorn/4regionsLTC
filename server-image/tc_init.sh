#!/usr/bin/env bash

# clear qdisc
tc qdisc del dev eth0 root    2> /dev/null > /dev/null
tc qdisc del dev eth0 ingress 2> /dev/null > /dev/null

tc qdisc add dev eth0 root handle 1:0 htb default 30
tc class add dev eth0 parent 1:0 classid 1:1 htb rate 1000mbit
tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 0.0.0.0/0 flowid 1:1