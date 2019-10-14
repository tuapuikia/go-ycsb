#!/bin/sh

MONGOURI=$1
MONGOUSER=$2
MONGOPASS=$3
THREADNUM=$4

if [ -z "$MONGOURI" ] || [ -z "$MONGOUSER" ] || [ -z "$MONGOPASS" ]; then
  echo "Mongo URI, user , pass cannot be empty"
  exit
else
  if [ -z "$THREADNUM" ]; then
    ycsbthread=10
  else
    ycsbthread="$THREADNUM"
  fi
fi


# Load data to database
./go-ycsb load mongodb -p mongodb.uri=mongodb://"$MONGOURI" -p mongodb.username="$MONGOUSER" -p mongodb.password="$MONGOPASS" -p mongodb.namespace=ycsb.ycsb -P workloads/workloada --threads "$ycsbthread"

# Generate load to database
./go-ycsb run mongodb -p mongodb.uri=mongodb://"$MONGOURI" -p mongodb.username="$MONGOUSER" -p mongodb.password="$MONGOPASS" -p mongodb.namespace=ycsb.ycsb -P workloads/workloada --threads "$ycsbthread"

