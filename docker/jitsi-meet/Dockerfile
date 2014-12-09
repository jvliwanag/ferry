FROM nginx:1.7
MAINTAINER Jan Vincent Liwanag <jvliwanag@gmail.com>

ADD https://github.com/jitsi/jitsi-meet/archive/252.tar.gz /tmp/jitsi-meet.tar.gz

RUN tar xvzf /tmp/jitsi-meet.tar.gz -C /tmp && \
  mv /tmp/jitsi-meet-* /srv/jitsi-meet && \
  rm /tmp/jitsi-meet.tar.gz

ADD nginx.conf /etc/nginx/nginx.conf

