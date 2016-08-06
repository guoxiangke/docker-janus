#!/bin/bash

# Patch Config to enable Event Handler
CFG_EVENT='/janus/etc/janus/janus.eventhandler.sampleevh.cfg'
sed 's/enabled = no/enabled = yes/1' -i $CFG_EVENT
echo 'backend = http://127.0.0.1:7777' >> $CFG_EVENT
CFG_JANUS='/janus/etc/janus/janus.cfg'
sed 's/broadcast = no/broadcast = yes/1' -i $CFG_JANUS
CFG_HTTPS='/janus/etc/janus/janus.transport.http.cfg'
sed 's/;https = no/https = yes/1' -i $CFG_HTTPS
sed 's/;secure_port = 8889/secure_port = 8089/1' -i $CFG_HTTPS

/root/janus/bin/janus --stun-server=stun.l.google.com:19302 -L /var/log/meetecho --rtp-port-range=10000-11000
tail -f /var/log/meetecho

