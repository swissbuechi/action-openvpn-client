#!/bin/bash
IP_ADDRESS=$1
MAX=10
INTERVAL=1
COUNTER=0
while [ $COUNTER -lt $MAX ]; do
  # shellcheck disable=SC2034
  output=$(ping -c 1 -W 1 "$IP_ADDRESS")
  # shellcheck disable=SC2181
  if [ $? -eq 0 ]; then
    echo "Ping was successful."
    exit 0
  else
    echo "Ping to $IP_ADDRESS failed."
    COUNTER=$((COUNTER+INTERVAL))
    sleep $INTERVAL
  fi
done
echo "Ping timed out"
exit 1