FROM dimaip/docker-neos-alpine:latest

MAINTAINER Dmitri Pisarev <dimaip@gmail.com>

# Basic build-time metadata as defined at http://label-schema.org
LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
	org.label-schema.license="MIT" \
	org.label-schema.name="Moodle Alpine Docker Image" \
	org.label-schema.url="https://github.com/psmb/docker-moodle-alpine" \
	org.label-schema.vcs-url="https://github.com/psmb/docker-moodle-alpine" \
	org.label-schema.vcs-type="Git"

COPY root /
COPY default.conf /etc/nginx/conf.d/default.conf

RUN set -x \
	&& apk update \
	&& apk add --virtual .temp-deps libxml2-dev zlib-dev \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install zip \
	&& docker-php-ext-install soap \
	&& docker-php-ext-install xmlrpc \
	&& docker-php-ext-enable mysqli \
	&& docker-php-ext-enable zip \
	&& docker-php-ext-enable soap \
	&& docker-php-ext-enable xmlrpc \
	&& apk del .temp-deps \
	&& rm -rf /var/cache/apk/*
