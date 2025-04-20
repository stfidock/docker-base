# This is the default base image for my containers
#
FROM debian:bookworm-slim

# checkov:skip=CKV_DOCKER_2:Not defining a health check in the base image
# checkov:skip=CKV_DOCKER_3:Not defining a user in the base image

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
