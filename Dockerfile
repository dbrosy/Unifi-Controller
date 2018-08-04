# Pull base image.
FROM ubuntu:16.04

MAINTAINER code@brosy.com

RUN echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50
RUN \
  apt-get -q --assume-no update && \
  apt-get install -qy unifi

# VOLUME /usr/lib/unifi/data
# VOLUME /usr/lib/unifi/logs

# Expose ports
EXPOSE 8080 8443 8880 8843

# Define working directory.
WORKDIR /usr/lib/unifi

# Define default command.
CMD ["/usr/bin/java", "-jar", "lib/ace.jar", "start"]
