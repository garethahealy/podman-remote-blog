#!/usr/bin/env bash

# Get a container to start from
container_id=$(buildah from registry.access.redhat.com/ubi8-minimal:8.0)

# Add metadata
buildah config --author="garethahealy (https://github.com/garethahealy/)" $container_id
buildah config --label name="podmanremote-yum-buildahbash" $container_id
buildah config --label vendor="com.garethahealy" $container_id
buildah config --label version="1.0" $container_id
buildah config --label license="Apache License, Version 2.0" $container_id

# Mount the container locally, so we can run things on the host directly
container_mount=$(buildah mount $container_id)

# yum is being run on the host, not within the container as we've told it to install to the mount dir instead of our host
yum install --installroot $container_mount -y zip --setopt tsflags=nodocs

# Unmount, since we've done all the host related tasks
buildah unmount $container_id

# Save image and tag it
buildah commit $container_id podmanremote-yum-buildahbash:latest