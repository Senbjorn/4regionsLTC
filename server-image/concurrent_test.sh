#!/usr/bin/env bash

test_name=$1

mkdir -p ./output/${test_name}/

iperf3 -c ${CLIENT_01} -p ${IPERF_PORT} --connect-timeout 10000 > ./output/${test_name}/client_01.txt &
iperf3 -c ${CLIENT_02} -p ${IPERF_PORT} --connect-timeout 10000 > ./output/${test_name}/client_02.txt &
iperf3 -c ${CLIENT_03} -p ${IPERF_PORT} --connect-timeout 10000 > ./output/${test_name}/client_03.txt &
iperf3 -c ${CLIENT_04} -p ${IPERF_PORT} --connect-timeout 10000 > ./output/${test_name}/client_04.txt &

for job in $(jobs -p);
do
    wait $job
done

echo "done" > ./output/${test_name}/done.txt