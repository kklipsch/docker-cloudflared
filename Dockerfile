FROM resin/armv7hf-debian-qemu as build

ENV DEBIAN_FRONTEND noninteractive
ENV TUNNEL_METRICS localhost:4000

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 4000/tcp

RUN [ "cross-build-start" ]

ADD config.yml /usr/local/etc/cloudflared/config.yml
ADD https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.tgz /usr/local/bin
RUN tar -xvzf /usr/local/bin/cloudflared-stable-linux-arm.tgz -C /usr/local/bin && \
    rm /usr/local/bin/cloudflared-stable-linux-arm.tgz && \
    chmod +x /usr/local/bin/cloudflared

RUN [ "cross-build-end" ]

ENTRYPOINT ["/usr/local/bin/cloudflared", "proxy-dns"]
