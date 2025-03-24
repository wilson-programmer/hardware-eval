#!/bin/bash

# Test write throughput by performing sequential writes with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=write_throughput \
  --numjobs=1 \
  --size=1G \
  --time_based \
  --runtime=60s \
  --ramp_time=1s \
  --ioengine=libaio \
  --direct=1 \
  --verify=0 \
  --bs=4k \
  --iodepth=64 \
  --rw=write \
  --group_reporting=1 \
  --write_bw_log=write_bw \
  --write_lat_log=write_lat \
  --write_hist_log=write_hist \
  --log_hist_msec=1 \
  --write_iops_log=write_iops >> write
  
  
  fio \
  --name=seq-write_throughput \
  --directory=$TEST_DIR \
  --numjobs=4 \
  --size=1G \
  --ioengine=libaio \
  --direct=1 \
  --verify=0 \
  --bs=1M \
  --iodepth=64 \
  --rw=write \
  --group_reporting=1 \
  --write_bw_log=seq-write \
  --write_lat_log=seq-write_lat \
  --write_hist_log=seq-write_hist \
  --log_hist_msec=1 \
  --write_iops_log=write_iops >>/home/wilson/bench_fio/seq-write_throughput.txt
  
  
  #Testez le débit en écriture à l'aide d'écritures séquentielles comportant plusieurs flux parallèles (plus de 16). 
  #Prévoyez une taille de bloc d'E/S de 1 Mo et une profondeur d'E/S d'au moins 64 
  
  sudo fio --name=write_throughput --directory=$TEST_DIR --numjobs=16 \
--size=10G --time_based --runtime=5m --ramp_time=2s --ioengine=libaio \
--direct=1 --verify=0 --bs=1M --iodepth=64 --rw=write \
--group_reporting=1 --iodepth_batch_submit=64 \
--iodepth_batch_complete_max=64

#Testez les IOPS en écriture à l'aide d'écritures aléatoires. Prévoyez une taille de bloc d'E/S de 4 ko et une profondeur d'E/S d'au moins 256 :
 sudo fio --name=write_iops --directory=$TEST_DIR --size=10G \
--time_based --runtime=5m --ramp_time=2s --ioengine=libaio --direct=1 \
--verify=0 --bs=4K --iodepth=256 --rw=randwrite --group_reporting=1  \
--iodepth_batch_submit=256  --iodepth_batch_complete_max=256

#Testez le débit en lecture à l'aide de lectures séquentielles comportant plusieurs flux parallèles (plus de 16). 
#Prévoyez une taille de bloc d'E/S de 1 Mo et une profondeur d'E/S d'au moins 64 :

sudo fio --name=read_throughput --directory=$TEST_DIR --numjobs=16 \
--size=10G --time_based --runtime=5m --ramp_time=2s --ioengine=libaio \
--direct=1 --verify=0 --bs=1M --iodepth=64 --rw=read \
--group_reporting=1 \
--iodepth_batch_submit=64 --iodepth_batch_complete_max=64 
--read_bw_log=seq-read \
  --read_lat_log=seq-read_lat \
  --read_hist_log=seq-read_hist \
  --log_hist_msec=1 \
  --read_iops_log=read_iops

#Testez les IOPS en lecture à l'aide de lectures aléatoires. Prévoyez une taille de bloc d'E/S de 4 ko et une profondeur d'E/S d'au moins 256 :
sudo fio --name=read_iops --directory=$TEST_DIR --size=10G \
--time_based --runtime=5m --ramp_time=2s --ioengine=libaio --direct=1 \
--verify=0 --bs=4K --iodepth=256 --rw=randread --group_reporting=1 \
--iodepth_batch_submit=256  --iodepth_batch_complete_max=256


#Structure complete


fio --name=write_throughput \
    --directory=$TEST_DIR\
    --numjobs=16 \
    --size=10G \
    --time_based \
    --runtime=5m \
    --ramp_time=2s \
    --ioengine=libaio \
    --direct=1 \
    --verify=0 \
    --bs=1M \
    --iodepth=64 \
    --rw=write \
    --group_reporting=1 \
    --iodepth_batch_submit=64 \
    --iodepth_batch_complete_max=64 \
    --write_bw_log=seq-write \
    --write_lat_log=seq-write_lat \
    --write_hist_log=seq-write_hist \
    --log_hist_msec=1 \
    --write_iops_log=write_iops>> /home/wilson/seq-write_throughput

# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*
wait
sleep 10

#Testez les IOPS en écriture à l'aide d'écritures aléatoires.
#Prévoyez une taille de bloc d'E/S de 4 ko et une profondeur 
#d'E/S d'au moins 256
fio --name=write_iops \
    --directory=$TEST_DIR \
    --size=10G \
    --time_based \
    --runtime=5m \
    --ramp_time=2s \
    --ioengine=libaio \
    --direct=1 \
    --verify=0 \
    --bs=4K \
    --iodepth=256 \
    --rw=randwrite \
    --group_reporting=1  \
    --iodepth_batch_submit=256 \
    --iodepth_batch_complete_max=256
    -write_bw_log=rand-write \
    --write_lat_log=rand-write_lat \
    --write_hist_log=rand-write_hist \
    --log_hist_msec=1 >>/home/wilson/bench_fio/rand-write_iops.txt

# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*

wait
sleep 10

#Testez le débit en lecture à l'aide de lectures
#séquentielles comportant plusieurs flux parallèles (plus de 16).
#Prévoyez une taille de bloc d'E/S de 1 Mo
#et une profondeur d'E/S d'au moins 64
fio --name=read_throughput \
    --directory=$TEST_DIR \
    --numjobs=16 \
    --size=10G \
    --time_based \
    --runtime=5m \
    --ramp_time=2s \
    --ioengine=libaio \
    --direct=1 \
    --verify=0 \
    --bs=1M \
    --iodepth=64 \
    --rw=read \
    --group_reporting=1 \
    --iodepth_batch_submit=64 \
    --iodepth_batch_complete_max=64 \
    --read_bw_log=seq-read \
    --read_lat_log=seq-read_lat \
    --read_hist_log=seq-read_hist \
    --log_hist_msec=1 \
    --read_iops_log=read_iops>>/home/wilson/bench_fio/seq-read_throughput.txt

# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*
wait 
sleep 10

#Testez les IOPS en lecture à l'aide de lectures
#aléatoires. Prévoyez une taille de bloc d'E/S de 4 ko et une
#profondeur d'E/S d'au moins 256

fio --name=read_iops \
    --directory=$TEST_DIR 
    --size=10G \
    --time_based \
    --runtime=5m \
    --ramp_time=2s \
    --ioengine=libaio \
    --direct=1 \
    --verify=0 \
    --bs=4K \
    --iodepth=256 \
    --rw=randread \
    --group_reporting=1 \
    --iodepth_batch_submit=256 \
    --iodepth_batch_complete_max=256 \
    --read_bw_log=rand-read \
    --read_lat_log=rand-read_lat \
    --read_hist_log=rand-read_hist \
    --log_hist_msec=1 \
    --read_iops_log=read_iops>>/home/wilson/bench_fio/rand-read_iops.txt 

# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*






#!/bin/bash
# Credit: https://cloud.google.com/compute/docs/disks/benchmarking-pd-performance

TEST_DIR=output_dir
mkdir -p $TEST_DIR

# Test write throughput by performing sequential writes with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=write_throughput \
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
  --group_reporting=1 >>/home/wilson/bench_fio/seq_write_throughput
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*


# Test read throughput by performing sequential reads with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=read_throughput \
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
  --group_reporting=1 >>/home/wilson/bench_fio/seq_read_throughput
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*




# Test write throughput by performing random writes with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=write_throughput \
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
  --group_reporting=1 >>/home/wilson/bench_fio/rand_write_throughput
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*


# Test read throughput by performing random reads with multiple parallel streams (8+), using an I/O block size of 1 MB and an I/O depth of at least 64:
fio \
  --name=read_throughput \
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
  --group_reporting=1 >>/home/wilson/bench_fio/rand_read_throughput
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*





# Test write IOPS by performing random writes, using an I/O block size of 4 KB and an I/O depth of at least 64:
fio \
  --name=write_iops \
  --directory=$TEST_DIR \
  --size=100M \
  --time_based \
  --runtime=60s \
  --ramp_time=2s \
  --ioengine=libaio \
  --direct=1 \
  --verify=0 \
  --bs=4K \
  --iodepth=64 \
  --rw=randwrite \
  --group_reporting=1 >>/home/wilson/bench_fio/rand_write_iops
# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*



# Test read IOPS by performing random reads, using an I/O block size of 4 KB and an I/O depth of at least 64:
fio \
  --name=read_iops \
  --directory=$TEST_DIR \
  --size=100M \
  --time_based \
  --runtime=60s \
  --ramp_time=2s \
  --ioengine=libaio \
  --direct=1 \
  --verify=0 \
  --bs=4K \
  --iodepth=64 \
  --rw=randread \
  --group_reporting=1 >> /home/wilson/bench_fio/rand_read_iops

# Clean up
rm -f $TEST_DIR/write* $TEST_DIR/read*

#!/bin/bash

/etc/init.d/redis-server start

redis-benchmark -n 1000000 -c 100 --csv -d 128 -P 8 >> redis_bench_result.csv