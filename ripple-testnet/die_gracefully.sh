#!/bin/bash
/opt/ripple/bin/rippled stop

i=0
while true; do
    echo "Waiting for rippled to kindly commit die $i"
    pids=`ps ax | grep rippled | grep -v grep | awk '{print $1}'`
    [[ -z "$pids" ]] && break
    sleep 10
    i=$[$i+10]
done
