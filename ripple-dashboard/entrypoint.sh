#!/bin/bash
: "${RIPPLE_NODE_IP:='ws://localhost:5006'}"
echo "using $RIPPLE_NODE_IP"
sed -i "s|RIPPLE_NODE_IP|${RIPPLE_NODE_IP}|g" /app/js/app*
nginx -g 'daemon off;'