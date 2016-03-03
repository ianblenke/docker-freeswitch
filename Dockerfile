FROM debian:jessie
MAINTAINER Ian Blenke "ian@blenke.com"

#ADD . /usr/src/freeswitch/src
WORKDIR /usr/src/freeswitch/src
RUN export DEBIAN_FRONTEND noninteractive && \
    apt-get -y -qq update && \
    apt-get -y install git aptitude && \
    mkdir -p /usr/src/freeswitch/src && \
    git clone https://bitbucket.org/ianblenke/freeswitch.git /usr/src/freeswitch/src/ && \
    echo "USENETWORK=yes" >$HOME/.pbuilderrc && \
    ./debian/util.sh build-all -ibn -z9 -aamd64 -cjessie

RUN find .. -name '*.dep' -print

RUN export DEBIAN_FRONTEND noninteractive && \
   dpkg -i ../*.deb && \
   cd /tmp && \
   apt-get clean && \
   rm -fr /usr/local/src/freeswitch &&\
   apt-get remove -y build-essential make autoconf automake libtool libavformat-dev libswscale-dev libncurses5-dev libopencv-dev libldns-dev libhiredis-dev ladspa-sdk libmemcached-dev libmp4v2-dev libosptk3-dev libsoundtouch-dev libopus-dev libldap2-dev libasound2-dev libx11-dev libh323plus-dev libopal-dev portaudio19-dev libx11-dev libperl-dev librabbitmq-dev libpq-dev erlang-dev libssl-dev erlang-dev libsnmp-dev libmagickcore-dev portaudio19-dev libogg-dev libvorbis-dev libsndfile1-dev libflac-dev libogg-dev libvlc-dev default-jdk gcj-jdk liblua5.2-dev libmono-2.0-dev mono-mcs libperl-dev python-dev libyaml-dev libldap2-dev libsasl2-dev && \
   apt-get autoremove -y &&\
RUN dpkg --purge build-essential autoconf automake libtool zlib1g-dev libjpeg-dev libncurses5-dev libssl-dev libcurl4-openssl-dev python-dev libexpat1-dev libtiff4-dev libx11-dev libavcodec-dev libavdevice-dev libavfilter-dev libavformat-dev libavutil-dev libavbin-dev libsofia-sip-ua-dev libvpx-dev libfreetype6-dev libjpeg-turbo8-dev erlang-dev uuid-dev libgdbm-dev ladspa-sdk libflac-dev libvlc-dev gcj-jdk libyaml-dev pkg-config libssl-dev unixodbc-dev libpq-dev libjpeg8-dev python-dev erlang-dev doxygen uuid-dev libexpat1-dev libgdbm-dev libdb-dev bison zlib1g-dev libogg-dev libasound2-dev libasound2-dev libx11-dev libpq-dev erlang-dev libsnmp-dev libflac-dev libogg-dev libvorbis-dev libvlc-dev default-jdk libperl-dev python-dev libyaml-dev libsqlite3-dev libpcre3-dev libspeex-dev libspeexdsp-dev libldns-dev libedit-dev libpq-dev libmemcached-dev python2.7-dev libgnutls-dev zlib1g-dev libidn11-dev libvlccore-dev cj-4.6-jdk comerr-dev libgcrypt11-dev libgcj12-dev zlib1g-dev gcj-4.6-jdk librtmp-dev krb5-multidev libgnutls-dev libkrb5-dev

VOLUME ["/etc/freeswitch"]
EXPOSE 8021
CMD ["/usr/bin/freeswitch","-c"]
