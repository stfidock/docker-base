# This is the default base image for my containers
#
FROM debian:bookworm-slim

ENV LC_ALL=C 
ENV DEBIAN_FRONTEND=noninteractive

# now install additional tools
#
RUN apt-get update && apt-get upgrade

# cleanup
#
RUN apt-get remove -y --purge --auto-remove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get the s6 in place
#
