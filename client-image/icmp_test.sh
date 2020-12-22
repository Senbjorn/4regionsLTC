#!/usr/bin/env bash

test_name=icmp

ping -c 10 -W 10 ${SERVER} > ./output/${test_name}/${CLIENT_NAME}.txt

echo "done" > ./output/${test_name}/${CLIENT_NAME}_done.txt