ARG DISTRO="alpine"
ARG DISTRO_VARIANT="3.19"
ARG cloudflare="2*"

FROM docker.io/tiredofit/${DISTRO}:${DISTRO_VARIANT}

ENV CONTAINER_ENABLE_MESSAGING=FALSE \
    CONTAINER_ENABLE_SCHEDULING=FALSE \
    CONTAINER_PROCESS_RUNAWAY_PROTECTOR=FALSE \
    IMAGE_NAME="flappje/traefik-cloudflare-companion" \
    IMAGE_REPO_URL="https://github.com/flappje/docker-traefik-cloudflare-companion/"

RUN source /assets/functions/00-container && \
    set -x && \
    addgroup -S -g 8080 tcc && \
    adduser -D -S -s /sbin/nologin \
      -h /dev/null \
      -G tcc \
      -g "tcc" \
      -u 8080 tcc

RUN package update && \
    package upgrade && \
    package install .tcc-build-deps \
      cargo \
      gcc \
      libffi-dev \
      musl-dev \
      openssl-dev \
      py-pip \
      py3-setuptools \
      py3-wheel \
      python3-dev

RUN package install .tcc-run-deps \
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

RUN pip --break-system-packages install \
      cloudflare==2* \
      get-docker-secret \
      requests

RUN package remove .tcc-build-deps && \
    package cleanup && \
    rm -rf /root/.cache \
      /root/.cargo

COPY install /
