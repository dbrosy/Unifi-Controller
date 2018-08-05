# Pull base image.
FROM ubuntu:16.04

MAINTAINER code@brosy.com

ENV DEBIAN_FRONTEND=noninteractive

# add unifi repository
RUN echo 'deb http://www.ubnt.com/downloads/unifi/debian oldstable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 

# add mongodb repository


RUN apt-get update && \
    apt-get -y install openjdk-8-jre-headless && \
    apt-get -y install mongodb-org-server jsvc binutils curl && \
    apt-get -y install unifi
    
VOLUME ["/var/lib/unifi"]

# Expose ports
EXPOSE 3478/udp 6789/tcp 8080/tcp 8443/tcp 8843/tcp 8880/tcp 10001/udp


# Define working directory.
WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]

# Define default command.
CMD ["start"]

