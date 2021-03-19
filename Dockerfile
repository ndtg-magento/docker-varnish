FROM alpine:latest

RUN apk update && apk add \
    gettext \
    iputils \
    iproute2 \
    gnupg \
    ca-certificates \
    netcat-openbsd \
    varnish

ENV VARNISH_SIZE=100M

ENV VARNISH_VERSION=6.5.1~buster-1

COPY ./docker/rootfs /rootfs

COPY ./default.vcl.template /etc/varnish/

COPY ./convert-params /usr/local/bin/convert-params

COPY ./docker-varnish-entrypoint /usr/local/bin/docker-varnish-entrypoint

RUN ln -s /usr/local/bin/convert-params

WORKDIR /etc/varnish

ENTRYPOINT ["/usr/local/bin/docker-varnish-entrypoint"]

EXPOSE 80 8443

CMD []