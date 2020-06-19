[![License](https://img.shields.io/hexpm/l/plug.svg?maxAge=2592000)]()

source start-podman.sh

# Using podman on MacOS via podman-remote and podman-machine
What is podman?

> What is Podman? Podman is a daemonless container engine for developing, managing, and running OCI Containers on your Linux System. 
> Containers can either be run as root or in rootless mode. Simply put: `alias docker=podman`.

- https://developers.redhat.com/blog/2019/02/21/podman-and-buildah-for-docker-users/

Why do i need to switch? Docker is fine...
- https://opensource.com/article/18/10/podman-more-secure-way-run-containers
- https://developers.redhat.com/blog/2018/12/19/security-considerations-for-container-runtimes/


Things to talk about:
- what is 
- podman-machine install via brew doesnt hit the required bits, if you wants it offered by core brew (https://github.com/boot2podman/machine/issues/5), star: https://github.com/boot2podman/machine
- podman isnt offered on mac due to dependency issues - https://github.com/containers/libpod/issues/1840
- podman-remote is early stage development, get involved at: https://podman.io/

# podman-machine and podman-remote are 
```bash
brew tap garethahealy/homebrew-boot2podman https://github.com/garethahealy/homebrew-boot2podman.git
```

# Install podman-machine
```bash
brew install podman-machine
```

# Start podman-machine
```bash
podman-machine create box
podman-machine start
eval $(podman-machine env)
```

# Set env vars needed by podman-remote
```bash
export PODMAN_REMOTE_SSHPORT=51768
export PODMAN_VARLINK_ADDRESS="tcp:127.0.0.1:${PODMAN_REMOTE_SSHPORT}"
```

# Start port forwarding to podman-machine in the background
```bash
ssh -fNTL 127.0.0.1:${PODMAN_REMOTE_SSHPORT}:/run/podman/io.podman root@${PODMAN_HOST} -i ~/.local/machine/machines/box/id_rsa -p ${PODMAN_PORT}
```

# Install podman-remote and check its working correctly
```bash
brew install podman-remote
podman-remote info
podman-remote help
```

# Lets run some commands
```bash
podman-remote pull registry.access.redhat.com/ubi8/ubi:8.0
podman-remote images
podman-remote inspect registry.access.redhat.com/ubi8/ubi:8.0
podman-remote run -i -t registry.access.redhat.com/ubi8/ubi:8.0 bash
podman-remote run --detach -t registry.access.redhat.com/ubi8/ubi:8.0 sleep 1m
podman-remote ps
podman-remote kill 1471a23624f7

podman-remote ps -a
podman-remote rm 1471a23624f7

podman-remote build -f builds/Pause/Dockerfile -t podmanremote-pause:latest
podman-remote build -f builds/YumRequired/Dockerfile -t podmanremote-yum:latest

podman-remote container create podmanremote-pause
podman-remote start 99fc72af7d77ee224f35e1fcddf26eed4bc47b7f33462c2a3f1dcb91a723c4b7
```
