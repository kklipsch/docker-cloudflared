FROM resin/armv7hf-debian-qemu as build

ENV DEBIAN_FRONTEND noninteractive

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 42255/tcp

ADD https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.tgz /usr/local/bin
RUN tar -xvzf /usr/local/bin/cloudflared-stable-linux-arm.tgz -C /usr/local/bin && \
    rm /usr/local/bin/cloudflared-stable-linux-arm.tgz && \
    chmod +x /usr/local/bin/cloudflared

ENTRYPOINT ["/usr/local/bin/cloudflared", "proxy-dns"]
