#!/bin/sh
[ -r /etc/default/snmpd ] && . /etc/default/snmpd
exec /usr/sbin/snmpd >> /var/log/snmpd.log 2>&1