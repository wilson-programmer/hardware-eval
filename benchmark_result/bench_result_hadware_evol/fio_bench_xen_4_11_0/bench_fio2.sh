#!/bin/bash
# Credit: https://cloud.google.com/compute/docs/disks/benchmarking-pd-performance

TEST_DIR=output_dir
mkdir -p $TEST_DIR

# Test write throughput by performing sequential writes with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=seq_write_throughput \
  --directory=$TEST_DIR \
  --numjobs=4 \
  --size=100M \
  --time_based \
  --runtime=60s \
  --ramp_time=2s \
  --ioengine=libaio \
  --direct=1 \
  --verify=0 \
  --bs=1M \
  --iodepth=64 \
  --rw=write \
  --group_reporting=1 >>/home/wilson/fio_bench/seq_write_throughput
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*


# Test read throughput by performing sequential reads with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=seq_read_throughput \
  --directory=$TEST_DIR \
  --numjobs=4 \
  --size=100M \
  --time_based \
  --runtime=60s \
  --ramp_time=2s \
  --ioengine=libaio \
  --direct=1 \
  --verify=0 \
  --bs=1M \
  --iodepth=64 \
  --rw=read \
  --group_reporting=1 >>/home/wilson/fio_bench/seq_read_throughput
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*




# Test write throughput by performing random writes with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=rand_write_throughput \
  --directory=$TEST_DIR \
  --numjobs=4 \
  --size=100M \
  --time_based \
  --runtime=60s \
  --ramp_time=2s \
  --ioengine=libaio \
  --direct=1 \
  --verify=0 \
  --bs=1M \
  --iodepth=64 \
  --rw=randwrite \
  --group_reporting=1 >>/home/wilson/fio_bench/rand_write_throughput
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*


# Test read throughput by performing random reads with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=rand_read_throughput \
  --directory=$TEST_DIR \
  --numjobs=4 \
  --size=100M \
  --time_based \
  --runtime=60s \
  --ramp_time=2s \
  --ioengine=libaio \
  --direct=1 \
  --verify=0 \
  --bs=1M \
  --iodepth=64 \
  --rw=randread \
  --group_reporting=1 >>/home/wilson/fio_bench/rand_read_throughput
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*
