FROM java:openjdk-7-jre
MAINTAINER Jan Vincent Liwanag <jvliwanag@gmail.com>

RUN VER=366 && wget -O /tmp/jvb.zip https://download.jitsi.org/jitsi-videobridge/linux/jitsi-videobridge-linux-x64-$VER.zip && \
  unzip -d /tmp /tmp/jvb.zip && \
  mv /tmp/jitsi-videobridge-linux-x64-$VER /opt/jitsi-videobridge && \
  rm /tmp/jvb.zip

RUN mkdir -p /root/.sip-communicator && \
  echo 'org.jitsi.impl.neomedia.transform.srtp.SRTPCryptoContext.checkReplay=false' > /root/.sip-communicator/sip-communicator.properties

ENTRYPOINT ["/opt/jitsi-videobridge/jvb.sh"]

