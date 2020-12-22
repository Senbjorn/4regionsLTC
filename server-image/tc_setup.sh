#!/usr/bin/env bash

# get ip addresses
ip_01=$(dig "${CLIENT_01}" +short)
ip_02=$(dig "${CLIENT_02}" +short)
ip_03=$(dig "${CLIENT_03}" +short)
ip_04=$(dig "${CLIENT_04}" +short)

echo $ip_01
echo $ip_02
echo $ip_03
echo $ip_04

# clear qdisc
tc qdisc del dev eth0 root    2> /dev/null > /dev/null
tc qdisc del dev eth0 ingress 2> /dev/null > /dev/null

# bandwidth split
tc qdisc add dev eth0 parent 1:1 handle 10:0 htb default 30

tc class add dev eth0 parent 10:0 classid 10:11 htb rate 400mbit
tc class add dev eth0 parent 10:0 classid 10:12 htb rate 200mbit
tc class add dev eth0 parent 10:0 classid 10:13 htb rate 200mbit
tc class add dev eth0 parent 10:0 classid 10:14 htb rate 200mbit

tc filter add dev eth0 protocol ip parent 10:0 prio 1 u32 match ip dst ${ip_01} flowid 10:11
tc filter add dev eth0 protocol ip parent 10:0 prio 1 u32 match ip dst ${ip_02} flowid 10:12
tc filter add dev eth0 protocol ip parent 10:0 prio 1 u32 match ip dst ${ip_03} flowid 10:13
tc filter add dev eth0 protocol ip parent 10:0 prio 1 u32 match ip dst ${ip_04} flowid 10:14

# udp priority for zone 2
tc qdisc add dev eth0 parent 10:12 handle 20:0 htb default 30

tc class add dev eth0 parent 20:0 classid 20:1 htb rate 200mbit
tc class add dev eth0 parent 20:0 classid 20:2 htb rate 5mbit ceil 200mbit

tc filter add dev eth0 protocol ip parent 20:0 prio 1 u32 match ip dst ${ip_02} match ip protocol 17 0xff flowid 20:1
tc filter add dev eth0 protocol ip parent 20:0 prio 2 u32 match ip dst ${ip_02} flowid 20:2


# ingore ingress packets
tc qdisc add dev eth0 ingress
tc filter add dev eth0 protocol ip parent ffff: prio 2 u32 match ip protocol 1 0xff action drop flowid :1
tc filter add dev eth0 protocol ip parent ffff: prio 1 u32 match ip dport 22 0xffff match ip src ${ip_03} action drop flowid :1