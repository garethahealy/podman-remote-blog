FROM registry.access.redhat.com/ubi8/ubi:8.0

LABEL Name="podmanremote-pause" \
    Vendor="com.garethahealy" \
    Maintainer="garethahealy (https://github.com/garethahealy/)" \
    Version="1.0" \
    License="Apache License, Version 2.0"

ADD pause /usr/bin/pause
RUN chmod +x /usr/bin/pause

ENTRYPOINT ["/usr/bin/pause"]