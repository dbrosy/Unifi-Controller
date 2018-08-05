# Pull base image.
FROM ubuntu:xenial

MAINTAINER code@brosy.com

#ENV BASEDIR=/usr/lib/unifi \
#  DATADIR=/var/lib/unifi \
#  RUNDIR=/var/run/unifi \
#  LOGDIR=/var/log/unifi \
#  DEBIAN_FRONTEND=noninteractive

#RUN apt-get update && \
#    apt-get -y install \
#    apt-transport-https \
#    ca-certificates \
#    curl \
#    software-properties-common


#RUN apt-get -y install \
#    binutils \
#    coreutils \
#    adduser \
#    libcap2 \
#    curl \
#    openjdk-8-jre-headless \
#    jsvc

RUN echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 

#RUN apt-get update && \
#    apt-get -y install unifi

# VOLUME /usr/lib/unifi/data
# VOLUME /usr/lib/unifi/logs

# Expose ports
EXPOSE 3478/udp 6789/tcp 8080/tcp 8443/tcp 8843/tcp 8880/tcp 10001/udp

# Define working directory.
WORKDIR /usr/lib/unifi

# Define default command.
#CMD ["/usr/bin/java", "-jar", "lib/ace.jar", "start"]
