#!/bin/sh
OLD_MIBS_DIR="/usr/share/mibs/site:/usr/share/snmp/mibs:/usr/share/mibs/iana:/usr/share/mibs/ietf:/usr/share/mibs/netsnmp"
MIBS_DIR="/usr/share/snmp/mibs:/usr/share/snmp/mibs/iana:/usr/share/snmp/mibs/ietf"
export MIBDIRS="$MIBS_DIR:$OLD_MIBS_DIR"
SNMPDRUN="yes"
SNMPDOPTS='-Lsd -Lf /dev/null -f -u snmp -g snmp -I -smux,mteTrigger,mteTriggerConf -p /var/run/snmpd.pid'
exec /usr/sbin/snmpd $SNMPDOPTS