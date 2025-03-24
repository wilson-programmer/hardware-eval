#!/bin/bash

#Launch netperf benchmark inside virtual machines

#Install netperf

# apt install -y sysstat wget tar automake make gcc
# wget -O netperf-2.7.0.tar.gz -c  https://codeload.github.com/HewlettPackard/netperf/tar.gz/netperf-2.7.0
# tar zxf netperf-2.7.0.tar.gz
# cd netperf-netperf-2.7.0
# ./configure && make && make install
# pkill netserver && pkill netperf

#Launch netperf
#Throughput
netperf -t UDP_STREAM -H 172.16.20.4 -l 1000 -- -m 64 -R 1 >> /home/wilson/netperf_result/netperf_output

netperf -t UDP_RR -H 172.16.20.4 -l 1000 -- -m 64 -R 1 >> /home/wilson/netperf_result/netperf_output


netperf -t TCP_STREAM -H 172.16.20.4 -l 1000 -- -m 1500 -R 1 >> /home/wilson/netperf_result/netperf_output

netperf -t TCP_RR -H 172.16.20.4 -l 1000 -- -r 32,128 -R 1 >> /home/wilson/netperf_result/netperf_output


