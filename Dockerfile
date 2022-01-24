FROM nodered/node-red:latest
USER root

RUN apk add --no-cache ffmpeg
RUN npm config set cache /usr/src/node-red/.npm --global \
    && npm install --unsafe-perm --no-update-notifier --only=production node-red-contrib-homekit-bridged \
    && npm install --unsafe-perm --no-update-notifier --only=production @node-red-contrib-themes/midnight-red
COPY ./nodered-homekit.sh /sbin/nodered-homekit

ENTRYPOINT []
CMD ["/sbin/nodered-homekit"]
