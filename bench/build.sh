#!/usr/bin/env bash

cd pipe
gcc -O3 -fPIC pipe_throughput.c -o pipe_throughput 
gcc -O3 -fPIC dev_null.c -o dev_null
./run_pipe.sh

cd ../spawn
gcc -O3 -fPIC spawn_child.c -o spawn_child 
gcc -O3 -fPIC spawn_victim.c -o spawn_victim
./run_spawn.sh

cd ../unix_socket_throughput
OCCLUM_TEST_GLIBC=1 make

cd ../data_sink
OCCLUM_TEST_GLIBC=1 make

cd ../build
./run_uds.sh
