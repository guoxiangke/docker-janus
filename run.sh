#!/bin/bash

/root/janus/bin/janus --stun-server=stun.l.google.com:19302 -L /var/log/meetecho --rtp-port-range=10000-11000
tail -f /var/log/meetecho

