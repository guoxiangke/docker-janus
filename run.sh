#!/bin/bash

# Patch Config to enable Event Handler
CFG_EVENT='/root/janus/etc/janus/janus.eventhandler.sampleevh.cfg'
sed 's/enabled = no/enabled = yes/1' -i $CFG_EVENT
echo 'backend = http://127.0.0.1:7777' >> $CFG_EVENT
CFG_JANUS='/root/janus/etc/janus/janus.cfg'
sed 's/; broadcast = yes/broadcast = yes/1' -i $CFG_JANUS
CFG_HTTPS='/root/janus/etc/janus/janus.transport.http.cfg'
sed 's/https = no/https = yes/1' -i $CFG_HTTPS
sed 's/;secure_port = 8889/secure_port = 8089/1' -i $CFG_HTTPS

# Start demo server
npm install http-server -g
ln -s /usr/bin/nodejs /usr/bin/node
http-server /root/janus/share/janus/demos/ --key /usr/share/doc/libssl-doc/demos/sign/key.pem --cert /usr/share/doc/libssl-doc/demos/sign/cert.pem -d false -p 8080 -c-1 --ssl &

/root/janus/bin/janus --stun-server=stun.l.google.com:19302 -L /var/log/meetecho --rtp-port-range=10000-11000
tail -f /var/log/meetecho

