#!/usr/bin/env bash

docker build ./iperf3-image/ -t my-iperf3
docker build ./server-image/ -t my-server
docker build ./client-image/ -t my-client