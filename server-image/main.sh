#!/usr/bin/env bash

function wait_file () {
    path=$1
    while [ ! -e "$path" ];
    do
        sleep 1s
        echo wait $path >> ./output/log.txt
    done
    sleep 1s
}

# clear output
rm -r ./output/*

# setup server on ssh port
iperf3 -s -p 22 > ./output/server_iperf_ssh_port_server_log.txt &

# create logs
tc_log=./output/tc_log.txt
printf "" > $tc_log
printf "" > ./output/log.txt

# creat client test dirs
mkdir ./output/ssh/
mkdir ./output/icmp/

# initial tc setup
bash tc_init.sh >> $tc_log

wait_file ./output/${CLIENT_01}_iperf_server_log.txt
wait_file ./output/${CLIENT_02}_iperf_server_log.txt
wait_file ./output/${CLIENT_03}_iperf_server_log.txt
wait_file ./output/${CLIENT_04}_iperf_server_log.txt

echo bandwidth_test >> ./output/log.txt

bash concurrent_test.sh initial

# full tc setup
echo tc_setup >> ./output/log.txt
bash tc_setup.sh >> $tc_log

echo bandwidth_test >> ./output/log.txt
bash concurrent_test.sh base

echo udp_test >> ./output/log.txt
bash udp_test.sh udp

wait_file ./output/icmp/${CLIENT_01}_done.txt
wait_file ./output/icmp/${CLIENT_02}_done.txt
wait_file ./output/icmp/${CLIENT_03}_done.txt
wait_file ./output/icmp/${CLIENT_04}_done.txt
