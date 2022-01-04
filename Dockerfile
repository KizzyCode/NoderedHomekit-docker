FROM nodered/node-red:latest
USER root

RUN apk add --no-cache dbus avahi-compat-libdns_sd avahi-dev ffmpeg \
    && rm /etc/avahi/services/*.service
RUN npm config set cache /usr/src/node-red/.npm --global \
    && npm install --unsafe-perm --no-update-notifier --only=production node-red-contrib-homekit-bridged

COPY ./files/avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY ./files/http.service /etc/avahi/services/http.service
COPY ./nodered-homekit.sh /sbin/nodered-homekit

ENTRYPOINT []
CMD ["/sbin/nodered-homekit"]
