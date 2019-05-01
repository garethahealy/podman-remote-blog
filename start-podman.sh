#!/usr/bin/env bash

#podman-machine create fed --virtualbox-boot2podman-url https://github.com/garethahealy/boot2podman-fedora-iso/releases/download/df8abe3/boot2podman-fedora.iso

podman-machine stop fed
podman-machine start fed
podman-machine inspect fed
podman-machine ssh fed sudo dnf update -y podman --enablerepo=updates-testing
eval $(podman-machine env fed)

export PODMAN_REMOTE_SSHPORT=51768
export PODMAN_VARLINK_ADDRESS="tcp:127.0.0.1:${PODMAN_REMOTE_SSHPORT}"

ssh -fNTL 127.0.0.1:${PODMAN_REMOTE_SSHPORT}:/run/podman/io.podman root@${PODMAN_HOST} -i ~/.local/machine/machines/fed/id_rsa -p ${PODMAN_PORT}

podman-remote info