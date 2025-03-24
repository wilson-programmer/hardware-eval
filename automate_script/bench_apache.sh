#!/bin/bash

#Launch apache benchmark inside virtual machines

ab -n 100000 -c 100 -e /home/wilson/apache_result/apache_bench_result.csv https://www.apache.org/
