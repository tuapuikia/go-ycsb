#!/bin/sh

REDISURI=$1
REDISDB=$2
THREADNUM=$3

if [ -z "$REDISURI" ] || [ -z "$REDISDB" ]; then
  echo "Redis host and db cannot be empty"
  exit
  else
    if [ -z "$THREADNUM" ]; then
      ycsbthread=10
    else
      ycsbthread="$THREADNUM"
    fi
  fi

# Load data to database
./go-ycsb load redis -p redis.addr="$REDISURI" -p redis.db="$REDISDB" -P workloads/workloada --threads "$ycsbthread"

# Generate load to database
./go-ycsb run redis -p redis.addr="$REDISURI" -p redis.db="$REDISDB" -P workloads/workloada --threads "$ycsbthread"

