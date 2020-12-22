#!/usr/bin/env bash

function wait_file () {
    path=$1
    while [ ! -e "$path" ];
    do
        sleep 1s
        echo wait $path >> ./output/log_${CLIENT_NAME}.txt
    done
    sleep 1s
}

sleep 1s

printf "" > ./output/log_${CLIENT_NAME}.txt

iperf3 -s -p ${IPERF_PORT} > ./output/${CLIENT_NAME}_iperf_server_log.txt &
iperf3 -s -p ${IPERF_UDP_PORT} > ./output/${CLIENT_NAME}_iperf_udp_server_log.txt &

wait_file ./output/udp/done.txt

if [[ "${CLIENT_NAME}" == "client-02" ]];
then
    wait_file ./output/ssh/client-01_done.txt
fi
if [[ "${CLIENT_NAME}" == "client-03" ]];
then
    wait_file ./output/ssh/client-02_done.txt
fi
if [[ "${CLIENT_NAME}" == "client-04" ]];
then
    wait_file ./output/ssh/client-03_done.txt
fi

bash ssh_test.sh
bash icmp_test.sh
