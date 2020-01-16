![Docker Stars](https://img.shields.io/docker/stars/ntuangiang/magento-varnish.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/ntuangiang/magento-varnish.svg)
![Docker Automated build](https://img.shields.io/docker/automated/ntuangiang/magento-varnish.svg)

# Magento 2 Varnish
[https://varnish-cache.org](https://varnish-cache.org) Varnish Cache is a web application accelerator also known as a caching HTTP reverse proxy. You install it in front of any server that speaks HTTP and configure it to cache the contents. Varnish Cache is really, really fast. It typically speeds up delivery with a factor of 300 - 1000x, depending on your architecture.
                                                             
[https://devdocs.magento.com](https://devdocs.magento.com) Meet the small business, mid-sized business, and enterprise-level companies who are benefiting from the power and flexibility of Magento on their web stores. We built the eCommerce platform, so you can build your business.

## Docker Repository
[ntuangiang/magento-varnish](https://hub.docker.com/r/ntuangiang/magento-varnish) 
## Usage
Write `docker-compose.yml` to start services.
```bash
version: '3.7'

services:
  m2varnish:
    image: ntuangiang/magento-varnish
    environment:
      - VARNISH_BACKEND_PORT=80
      - VARNISH_PURGE_HOST=m2nginx
      - VARNISH_BACKEND_HOST=m2nginx
      - VARNISH_HEALTH_CHECK_FILE=/health_check.php
    labels:
      - traefik.port=80
      - traefik.enable=true
      - traefik.docker.network=traefik_proxy
      - traefik.frontend.entryPoints=https,http
      - traefik.frontend.rule=Host:magento2.dev.traefik;PathPrefix:/
    networks:
      - traefik

  m2nginx:
    image: ntuangiang/magento-nginx
    volumes:
      - ./:/yourDir
    environment:
      - NGINX_BACKEND_HOST=m2php
      - MAGE_MODE=developer
    networks:
      - backend
      - traefik

  m2php:
    image: ntuangiang/magento:2.3.3-develop
    env_file: docker-compose.env
    volumes:
      - ./:/yourDir
    networks:
      - backend

  m2db:
    image: mysql
    command: --default-authentication-plugin=mysql_native_password
    volumes:
      - /yourDir:/var/lib/mysql
    ports:
      - '2336:3306'
    environment:
      - MYSQL_ROOT_PASSWORD=root
      - MYSQL_DATABASE=magento2
    networks:
      - backend

  m2redis:
    image: redis:alpine
    networks:
      - backend

networks:
  backend:
  traefik:
    external:
      name: traefik_proxy
```

## LICENSE

MIT License