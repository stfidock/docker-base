# This is the default base image for my containers
#
FROM debian:bookworm-slim

# checkov:skip=CKV_DOCKER_2:Not defining a health check in the base image
# checkov:skip=CKV_DOCKER_3:Not defining a user in the base image

# Environment variables
#
ENV LC_ALL=C 
ENV DEBIAN_FRONTEND=noninteractive

# Arguments
#
ARG S6_OVERLAY_VERSION=3.2.0.2

# now install additional tools
#
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y procps xz-utils

# cleanup
#
RUN apt-get remove -y --purge --auto-remove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get the s6 as the init in place
# https://github.com/just-containers/s6-overlay
#
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

ENTRYPOINT ["/init"]
