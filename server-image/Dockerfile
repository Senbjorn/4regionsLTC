FROM my-iperf3
RUN mkdir -p /usr/src/scripts/
RUN mkdir -p /usr/src/scripts/output/

WORKDIR /usr/src/scripts/

ENV IPERF_PORT=8080
ENV IPERF_UDP_PORT=8081
ENV CLIENT_01=client-01
ENV CLIENT_02=client-02
ENV CLIENT_03=client-03
ENV CLIENT_04=client-04

ADD ./main.sh .
ADD ./tc_init.sh .
ADD ./tc_setup.sh .
ADD ./udp_test.sh .
ADD ./concurrent_test.sh .

# CMD bash ./iperf_client.sh ${IPERF_PORT} ${CLIENT_01} ${OUTPUT_FILE}
CMD bash main.sh
