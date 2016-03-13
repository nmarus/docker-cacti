#Dockerfile for Cacti Cacti-Spine
#https://github.com/nmarus/docker-cacti
#nmarus@gmail.com
FROM phusion/baseimage

# Setup APT
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-backports main restricted" >> /etc/apt/sources.list.d/non-free.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) multiverse" >> /etc/apt/sources.list.d/non-free.list

# Update, Install Prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  apt-get install -y vim curl wget perl && \
  apt-get install -y build-essential mysql-client mysql-server snmpd python-netsnmp libnet-snmp-perl snmp-mibs-downloader

# Install Cacti
RUN DEBIAN_FRONTEND=noninteractive /etc/init.d/mysql start && \
  sleep 10 && \
  apt-get install -y cacti cacti-spine && \
  /etc/init.d/mysql stop && \
  sleep 10

# Clean up APT
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup mysqld daemon
RUN mkdir /etc/service/mysqld
COPY mysqld.sh /etc/service/mysqld/run
RUN chmod +x /etc/service/mysqld/run

# Setup snmpd daemon
RUN mkdir /etc/service/snmpd
COPY snmpd.sh /etc/service/snmpd/run
RUN chmod +x /etc/service/snmpd/run

# Setup apache2 daemon
RUN echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf
RUN ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf
RUN mkdir /etc/service/apache2
COPY apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run
RUN mv /var/www/html/index.html /var/www/html/index.php && \
  echo "<?php header('Location: /cacti') ; ?>" > /var/www/html/index.php

# Service Ports
EXPOSE 80 161

# Start init system
CMD ["/sbin/my_init"]
