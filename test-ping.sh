#!/bin/bash
COUNTER=0
while [ $COUNTER -lt 10 ]; do
  # shellcheck disable=SC2034
  output=$(ping -c 1 -W 1 ${{ inputs.test-ping-ip-host }}")
  # shellcheck disable=SC2181
  if [ $? -eq 0 ]; then
    echo "Ping was successful."
    exit 0
  else
    echo "Ping to ${{ inputs.test-ping-ip-host }} failed."
    COUNTER=$((COUNTER+1))
    sleep 1
  fi
done
echo "Ping timed out"
exit 1