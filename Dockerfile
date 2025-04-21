# This is the default base image for my containers
#
FROM debian:bookworm-slim

# hadolint global ignore=DL3008
#
# DL3008 is a warning, that pinning of the installed version is prefered

# Environment variables
#
ENV LC_ALL=C 
ENV DEBIAN_FRONTEND=noninteractive

# Arguments
#
ARG S6_OVERLAY_VERSION=3.2.0.2

# now install additional tools
#
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends procps xz-utils \
    && apt-get remove -y --purge --auto-remove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

# get the s6 as the init in place
# https://github.com/just-containers/s6-overlay
#
WORKDIR /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz.sha256 /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz.sha256 /tmp
RUN sha256sum --check /tmp/s6-overlay*.sha256 \
    && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

WORKDIR /

ENTRYPOINT ["/init"]
