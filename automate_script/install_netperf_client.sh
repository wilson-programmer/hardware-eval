#!/bin/bash

apt install -y sysstat wget tar automake make gcc
wget -O netperf-2.7.0.tar.gz -c  https://codeload.github.com/HewlettPackard/netperf/tar.gz/netperf-2.7.0
tar zxf netperf-2.7.0.tar.gz
cd netperf-netperf-2.7.0
./configure && make && make install
pkill netserver && pkill netperf
