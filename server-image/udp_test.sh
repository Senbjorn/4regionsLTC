#!/usr/bin/env bash

test_name=$1
mkdir -p ./output/${test_name}/

function test () {
    client=$1
    test_name=$2
    iperf3 -c ${client} -p ${IPERF_PORT} --connect-timeout 10000 > ./output/${test_name}/${client}.txt &
    iperf3 -c ${client} -p ${IPERF_UDP_PORT} -u --connect-timeout 10000 > ./output/${test_name}/${client}_udp.txt &

    for job in $(jobs -p);
    do
        wait $job
    done
}

test ${CLIENT_01} ${test_name}
test ${CLIENT_02} ${test_name}
test ${CLIENT_03} ${test_name}
test ${CLIENT_04} ${test_name}

echo "done" > ./output/${test_name}/done.txt