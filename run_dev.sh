#!/usr/bin/env bash

bash build_images.sh
docker-compose up -d
sudo docker run --rm --name test-iperf3 --volume 4regionsltc_4region_out:/usr/src/out --network my-net --network-alias test -it my-iperf3
sudo docker rm -f $(sudo docker ps -a -q)