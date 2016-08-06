FROM ubuntu:16.04

# bootstrap environment
ENV DEPS_HOME="/root/janus"
ENV SCRIPTS_PATH="/tmp/scripts"

# use aarnet mirror for quicker building while developing
RUN sed -i 's/archive.ubuntu.com/mirror.aarnet.edu.au\/pub\/ubuntu\/archive/g' /etc/apt/sources.list

# install baseline package dependencies
RUN apt-get -y update && apt-get install -y libmicrohttpd-dev \
  libjansson-dev \
  libcurl4-openssl-dev \
  libnice-dev \
  libssl-dev \
  libsrtp-dev \
  libsofia-sip-ua-dev \
  libglib2.0-dev \
  libopus-dev \
  libogg-dev \
  libini-config-dev \
  libcollection-dev \
  pkg-config \
  gengetopt \
  libtool \
  automake \
  build-essential \
  subversion \
  git \
  cmake \
  wget

ADD scripts/bootstrap.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/bootstrap.sh

ENV JANUS_RELEASE="v0.1.2"
ADD scripts/janus.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/janus.sh
RUN touch /var/log/meetecho

COPY run.sh /run.sh
RUN chmod a+rx /run.sh

EXPOSE 10000-11000
EXPOSE 8088
EXPOSE 8089
EXPOSE 8000
EXPOSE 7088
EXPOSE 7089

ENTRYPOINT ["/run.sh"]
