#!/bin/bash
DOMAIN_NAME=$1
DNS_SERVER=$2
MAX=10
INTERVAL=1
COUNTER=0
while [ $COUNTER -lt $MAX ]; do
  # shellcheck disable=SC2034
  output=$(dig @"$DNS_SERVER" +short "$DOMAIN_NAME")
  # shellcheck disable=SC2181
  if [ $? -eq 0 ]; then
    echo "DNS resolution was successful."
    exit 0
  else
    echo "DNS resolution failed."
    COUNTER=$((COUNTER+INTERVAL))
    sleep $INTERVAL
  fi
done
echo "DNS resolution timed out"
exit 1