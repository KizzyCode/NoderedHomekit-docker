#!/bin/bash
set -eu

# Repair permissions
chown -R node-red:node-red "/data"
chmod u=rwX,g=,o= "/data"

# Start NodeRED
exec su -l node-red <<EOF
    cd /usr/src/node-red
    exec npm --no-update-notifier --no-fund start --cache /data/.npm -- --userDir /data
EOF
