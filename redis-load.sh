#!/bin/sh

REDISURI=$1
THREADNUM=$2

if [ -z "$REDISURI" ]; then
  echo "Redis host cannot be empty"
  exit
  else
    if [ -z "$THREADNUM" ]; then
      ycsbthread=10
    else
      ycsbthread="$THREADNUM"
    fi
  fi

# Load data to database
./go-ycsb load redis -p redis.addr="$REDISURI" -P workloads/workloada --threads "$ycsbthread"

# Generate load to database
./go-ycsb run redis -p redis.addr="$REDISURI" -P workloads/workloada --threads "$ycsbthread"

