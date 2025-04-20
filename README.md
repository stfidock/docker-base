# stfi docker-base

The baseimage for my docker containers, based on Debian Bookworm-Slim

It contains:
- updated os
- core utils (ps, tar, xz, ...)
- s6 overlay init system
- actions: linting
- actions: docker build
- actions: docker upload to dockerhub
