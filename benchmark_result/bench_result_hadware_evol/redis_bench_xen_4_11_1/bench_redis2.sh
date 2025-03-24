#!/bin/bash

/etc/init.d/redis-server start

redis-benchmark -n 1000000 -c 100 --csv -d 128 -P 8 >> redis_bench_result.csv
