#!/bin/bash
set -eu

# Repair permissions
chown -R node-red:node-red "/data"
chmod u=rwX,g=,o= "/data"

# Start NodeRED
su -l node-red <<EOF
    cd /usr/src/node-red
    npm --no-update-notifier --no-fund start --cache /data/.npm -- --userDir /data
EOF
