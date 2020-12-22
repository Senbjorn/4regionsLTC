#!/usr/bin/env bash

iperf_port=$1
iperf_host=$2
output_file=$3
attemps=100

connection_status=1
attemp_number=1
printf "connecting to %s:%s\n" $iperf_host $iperf_port
while (( connection_status != 0 ));
do
	printf "attemp %d\n" $attemp_number
	attemps=$((attemps - 1))
	attemp_number=$((attemp_number + 1))
	iperf3 -c $iperf_host -p $iperf_port=8080 > $output_file
	connection_status=$?
	if (( attemps == 0 ));
	then
		exit 2
	fi
	sleep 1s
done
printf "done\n"

exit 0
