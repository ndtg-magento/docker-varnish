FROM varnish:latest

RUN apt-get update && apt-get install -y \
    gettext-base \
    iputils-ping \
    iproute2

COPY ./docker/rootfs /rootfs

COPY ./default.vcl.template /etc/varnish/

COPY ./convert-params /usr/local/bin/convert-params

COPY ./docker-varnish-entrypoint /usr/local/bin/docker-varnish-entrypoint

RUN ln -s /usr/local/bin/convert-params
