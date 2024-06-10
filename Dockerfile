## docker buildx build . -t openttdv2

FROM ghcr.io/linuxserver/baseimage-alpine:3.20

RUN apk add --no-cache \
      cargo \
      gcc \
      libffi-dev \
      musl-dev \
      openssl-dev \
      py-pip \
      py3-setuptools \
      py3-wheel \
      python3-dev \
      docker-py \
      py3-beautifulsoup4 \
      py3-certifi \
      py3-chardet \
      py3-idna \
      py3-openssl \
      py3-packaging \
      py3-requests \
      py3-soupsieve \
      py3-urllib3 \
      py3-websocket-client \
      py3-yaml \
      python3

RUN pip install --break-system-packages \
      cloudflare==2.* \
      get-docker-secret \
      requests

RUN  echo "**** clean up ****" && \
     rm -rf \
      /tmp/*

COPY root /
