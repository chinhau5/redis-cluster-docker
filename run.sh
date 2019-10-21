#!/bin/bash

mkdir -p /redis
cd /redis

PORT=30000
TIMEOUT=2000
NODES=3
REPLICAS=0

# Computed vars
ENDPORT=$((PORT+NODES))

while [ $((PORT < ENDPORT)) != "0" ]; do
	PORT=$((PORT+1))
	echo "Starting $PORT"
	redis-server --port $PORT --cluster-enabled yes --cluster-config-file nodes-${PORT}.conf --cluster-node-timeout $TIMEOUT --appendonly yes --appendfilename appendonly-${PORT}.aof --dbfilename dump-${PORT}.rdb --logfile ${PORT}.log --daemonize yes
done

PORT=30000
HOSTS=""
while [ $((PORT < ENDPORT)) != "0" ]; do
	PORT=$((PORT+1))
	HOSTS="$HOSTS 127.0.0.1:$PORT"
done

echo $HOSTS
echo $REPLICAS
echo "yes" | redis-cli --cluster create $HOSTS --cluster-replicas $REPLICAS

tail -F /dev/null
