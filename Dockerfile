# FROM ubuntu:24.04
FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy
LABEL maintainer="Christopher Mayor toph.homelab+nordvpn@gmail.com"

# ARG NORDVPN_VERSION=3.17.4
# ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates && \
    apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates && \ 
    wget -qO /etc/apt/trusted.gpg.d/nordvpn_public.asc https://repo.nordvpn.com/gpg/nordvpn_public.asc && \
    echo "deb https://repo.nordvpn.com/deb/nordvpn/debian stable main" > /etc/apt/sources.list.d/nordvpn.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nordvpn && \
    apt-get clean && \
    rm -rf \
    /tmp/* \
    /var/cache/apt/archives/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# COPY boot.sh /
COPY /rootfs /
ENV S6_CMD_WAIT_FOR_SERVICES=1
CMD nord_login && nord_config && nord_connect && nord_watch