#!/usr/bin/env bash

# create a self signed cert for the server
mkdir -p $DEPS_HOME/certs/
openssl req \
  -new \
  -newkey rsa:4096 \
  -days 365 \
  -nodes \
  -x509 \
  -subj "/C=AU/ST=NSW/L=Sydney/O=JanusDemo/CN=janus.test.com" \
  -keyout $DEPS_HOME/certs/janus.key \
  -out $DEPS_HOME/certs/janus.pem

# wget https://github.com/meetecho/janus-gateway/archive/$JANUS_RELEASE.tar.gz -O  $DEPS_HOME/dl/janus.tar.gz
# cd $DEPS_HOME/dl
# tar xf janus.tar.gz

cd $DEPS_HOME/dl
git clone https://github.com/meetecho/janus-gateway
cd janus-gateway
git checkout event-handlers

./autogen.sh

# TODO: fix websocket support as it should work
./configure --prefix=$DEPS_HOME --disable-websockets --disable-rabbitmq --disable-docs
make
make install
make configs

