FROM my-iperf3

RUN mkdir -p /usr/src/scripts/
RUN mkdir -p /usr/src/scripts/output/
WORKDIR /usr/src/scripts/

ENV IPERF_PORT=8080
ENV IPERF_UDP_PORT=8081
ENV SERVER=server
ENV CLIENT_NAME=client

ADD ./main.sh .
ADD ./ssh_test.sh .
ADD ./icmp_test.sh .

CMD bash main.sh
