#Dockerfile for Cacti Cacti-Spine
#https://github.com/nmarus/docker-cacti
#nmarus@gmail.com
FROM phusion/baseimage

# Setup APT
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-backports main restricted" >> /etc/apt/sources.list.d/non-free.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) multiverse" >> /etc/apt/sources.list.d/non-free.list

# Update, Install Prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && apt-get upgrade -y && \
  apt-get install -y vim curl wget perl unzip git && \
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
  echo "<?php header('Location: /cacti');?>" > /var/www/html/index.php

# Install Aggregate Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O aggregate-070b2.tgz http://docs.cacti.net/_media/plugin:aggregate-070b2.tgz && \
  tar -zxvf aggregate-070b2.tgz && \
  rm aggregate-070b2.tgz && \
  mv aggregate-070B2/ aggregate

# Install CLog Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O clog-v1.7-1.tgz http://docs.cacti.net/_media/plugin:clog-v1.7-1.tgz && \
  tar -zxvf clog-v1.7-1.tgz && \
  rm clog-v1.7-1.tgz

# Install Cycle Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O cycle-v2.3-1.tgz http://docs.cacti.net/_media/plugin:cycle-v2.3-1.tgz && \
  tar -zxvf cycle-v2.3-1.tgz && \
  rm cycle-v2.3-1.tgz

# Install DSStats Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O dsstats-v1.4-1.tgz http://docs.cacti.net/_media/plugin:dsstats-v1.4-1.tgz && \
  tar -zxvf dsstats-v1.4-1.tgz && \
  rm dsstats-v1.4-1.tgz

# Install Error Image Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O errorimage-v0.2-1.tgz http://docs.cacti.net/_media/plugin:errorimage-v0.2-1.tgz && \
  tar -zxvf errorimage-v0.2-1.tgz && \
  rm errorimage-v0.2-1.tgz

# Install Monitor Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O monitor-v1.3-1.tgz http://docs.cacti.net/_media/plugin:monitor-v1.3-1.tgz && \
  tar -zxvf monitor-v1.3-1.tgz && \
  rm monitor-v1.3-1.tgz

# Install Nectar Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O nectar-v0.11.tgz http://docs.cacti.net/_media/plugin:nectar-v0.11.tgz && \
  tar -zxvf nectar-v0.11.tgz && \
  rm nectar-v0.11.tgz

# Install RRD Clean Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O rrdclean-latest.tgz http://docs.cacti.net/_media/plugin:rrdclean-latest.tgz && \
  tar -zxvf rrdclean-latest.tgz && \
  rm rrdclean-latest.tgz

# Install Realtime Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O realtime-v0.5-2.tgz http://docs.cacti.net/_media/plugin:realtime-v0.5-2.tgz && \
  tar -zxvf realtime-v0.5-2.tgz && \
  rm realtime-v0.5-2.tgz && \
  mkdir -p /usr/share/cacti/site/realtime && \
  chmod 777 /usr/share/cacti/site/realtime

# Install Remote Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O remote_v01.tar.gz http://docs.cacti.net/_media/plugin:remote_v01.tar.gz && \
  tar -zxvf remote_v01.tar.gz && \
  rm remote_v01.tar.gz

# Install Settings Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O settings-v0.71-1.tgz http://docs.cacti.net/_media/plugin:settings-v0.71-1.tgz && \
  tar -zxvf settings-v0.71-1.tgz && \
  rm settings-v0.71-1.tgz

# Install Spikekill Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O spikekill-v1.3-2.tgz http://docs.cacti.net/_media/plugin:spikekill-v1.3-2.tgz && \
  tar -zxvf spikekill-v1.3-2.tgz && \
  rm spikekill-v1.3-2.tgz

# Install SNMP Agent Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O snmpagent.tar.gz http://downloads.sourceforge.net/project/cactisnmpagent/0.2.3/snmpagent.tar.gz && \
  tar -zxvf snmpagent.tar.gz && \
  rm snmpagent.tar.gz && \
  unzip snmpagent.zip

# Install Syslog Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -q -O syslog-v1.22-2.tgz http://docs.cacti.net/_media/plugin:syslog-v1.22-2.tgz && \
  tar -zxvf syslog-v1.22-2.tgz && \
  rm syslog-v1.22-2.tgz

# Install THold Plugin 
# (using a temp fix for issue with https://github.com/Usuychik/thold)
RUN cd /usr/share/cacti/site/plugins/ && \
  git clone https://github.com/nmarus/thold

# Service Ports
EXPOSE 80 161

# Start init system
CMD ["/sbin/my_init"]
