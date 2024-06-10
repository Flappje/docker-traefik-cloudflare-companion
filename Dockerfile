## docker buildx build . -t openttdv2

FROM ghcr.io/linuxserver/baseimage-alpine:3.20

RUN \
  apk add --no-cache \
    openssl-dev \
    py-pip \
    docker-py \
    py3-certifi \
    py3-chardet \
    py3-openssl \
    py3-requests \
    py3-urllib3 \
    py3-websocket-client \
    py3-yaml \
    python3 \
  && \
  pip install --break-system-packages \
    cloudflare==2.19.* \
    get-docker-secret \
  && \
  echo "**** clean up ****" && \
  rm -rf \
    /tmp/*

COPY root /
