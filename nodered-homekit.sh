#!/bin/bash
set -eu

# Set hostname
if test -z "$HOSTNAME"; then
  echo "!> Missing \$HOSTNAME"
  exit 1
fi
sed -i "s/.*host-name.*/host-name=$HOSTNAME/g" "/etc/avahi/avahi-daemon.conf"


# Set port
if test -z "$PORT"; then
  echo "!> Missing \$PORT"
  exit 1
fi
sed -i "s/.*<port>.*<\/port>.*/   <port>$PORT<\/port>/g" "/etc/avahi/services/http.service"


# Spawn DBus
dbus-daemon --system --nofork &
disown
until test -e "/var/run/dbus/system_bus_socket"; do
  sleep 1s
done


# Spawn avahi daemon
avahi-daemon --no-chroot -f /etc/avahi/avahi-daemon.conf &
disown


# Set permissions and start NodeRED
chown 1000:1000 /usr/src/node-red
cd /usr/src/node-red
node-red npm start -- --userDir /data
