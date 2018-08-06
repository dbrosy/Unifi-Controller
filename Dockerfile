# Pull base image.
FROM ubuntu:16.04

MAINTAINER code@brosy.com
ENV BASEDIR=/usr/lib/unifi \
    DATADIR=/var/lib/unifi \
    LOGDIR=/var/log/unifi \
    RUNDIR=/var/run/unifi \
    DEBIAN_FRONTEND=noninteractive
    
#ENV BASEDIR=/usr/lib/unifi \
#    DATADIR=/unifi/data \
#    LOGDIR=/unifi/log \
#    CERTDIR=/unifi/cert \
#    RUNDIR=/var/run/unifi \
#    DEBIAN_FRONTEND=noninteractive

# add unifi repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50
RUN echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list


# add mongodb repository (3.4)
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list

#RUN mkdir -p ${DATADIR} ${LOGDIR}


RUN set -ex \
    && fetchDeps=' \
        ca-certificates \
        wget \
    ' \
    && apt-get update \
    && apt-get -y install openjdk-8-jre-headless \
    && apt-get -y install mongodb-org-server jsvc binutils curl \
    && apt-get -y install mongodb-server jsvc binutils curl \
    && apt-get -y install unifi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -s ${DATADIR} ${BASEDIR}/data
RUN ln -s ${RUNDIR} ${BASEDIR}/run
RUN ln -s ${LOGDIR} ${BASEDIR}/logs

VOLUME ["${RUNDIR}"]

# Expose port
EXPOSE 3478/udp 6789/tcp 8080/tcp 8443/tcp 8843/tcp 8880/tcp 10001/udp


# Define working directory.
WORKDIR /unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]

# Define default command.
CMD ["start"]

