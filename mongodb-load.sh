#!/bin/sh

MONGOURI=$1
MONGOUSER=$2
MONGOPASS=$3
THREADNUM=$4
TARGETNUM=$5

if [ -z "$MONGOURI" ] || [ -z "$MONGOUSER" ] || [ -z "$MONGOPASS" ] || [ -z "$THREADNUM" ] || [ -z "$TARGETNUM" ]; then
  echo "Mongo URI, user , pass, thread count and target cannot be empty"
  echo "Example: ./mongodb-load.sh mongo-sh admin password 10 1000"
  exit
else

# Load data to database
./go-ycsb load mongodb -p mongodb.uri=mongodb://"$MONGOURI" -p mongodb.username="$MONGOUSER" -p mongodb.password="$MONGOPASS" -p mongodb.namespace=ycsb.ycsb -P workloads/workloada --threads "$THREADNUM"

# Generate load to database
./go-ycsb run mongodb -p mongodb.uri=mongodb://"$MONGOURI" -p mongodb.username="$MONGOUSER" -p mongodb.password="$MONGOPASS" -p mongodb.namespace=ycsb.ycsb -P workloads/workloada --threads "$THREADNUM" --target "$TARGETNUM"

