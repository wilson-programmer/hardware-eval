#!/bin/bash

/etc/init.d/redis-server start



redis-benchmark -n 100000 -c 100 --csv -d 128 -P 8 >> /home/wilson/redis_result/redis_bench_result.csv
