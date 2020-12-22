# 4regionsLTC
In this project we construct a network infrastructure with Linux Traffic Control

## Prerequisites
* Enable QoS in kernel
* Install docker and docker-compose

## How to run the network
* download the repo
* run the following command from the root of the project<br>
  $ bash run_dev.sh<br>
   - warning: it will stop all running containers, so make sure you don't have anything important running
   - you may need sudo
* you will see docker container terminal. Proceed to output directory<br>
  $ cd /usr/src/out/
* In the directory you will find all the results
  - base - bandwidth test
  - udp  - udp priority test
  - ssh - ssh drop test
  - icmp - icmp drop test
