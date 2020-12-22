#!/usr/bin/env bash

test_name=ssh

iperf3 -c ${SERVER} -p 22 --connect-timeout 10000 > ./output/${test_name}/${CLIENT_NAME}.txt

echo "done" > ./output/${test_name}/${CLIENT_NAME}_done.txt