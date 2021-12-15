# syntax = docker/dockerfile:experimental

ARG DISTRO
ARG DISTROVER
ARG ARCH

FROM ghcr.io/linuxserver/baseimage-${DISTRO}:${ARCH}-${DISTROVER}

ARG DISTRO
ARG DISTROVER
ARG PACKAGES

COPY packages.txt /packages.txt

RUN \
  if [ -f /usr/bin/apt ]; then \
    echo "**** Detected Ubuntu ****" && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
      cargo \
      g++ \
      libffi-dev \
      libjpeg-dev \
      libssl-dev \
      libxml2-dev \
      libxslt1-dev \
      make \
      python3-dev \
      python3-pip \
      zlib1g-dev; \
  else \
    echo "**** Detected Alpine ****" && \
    apk add --no-cache \
      cargo \
      g++ \
      gcc \
      jpeg-dev \
      libffi-dev \
      libxml2-dev \
      libxslt-dev \
      make \
      openssl-dev \
      py3-pip \
      python3-dev \
      zlib-dev; \
  fi

RUN \
  echo "**** Updating pip and building wheels ****" && \
  pip3 install -U pip setuptools wheel

RUN \
  --security=insecure mkdir -p /root/.cargo && chmod 777 /root/.cargo && mount -t tmpfs none /root/.cargo && \
  mkdir -p /build && \
  if [ -z "${PACKAGES}" ]; then \
    PACKAGES=$(cat /packages.txt); \
  fi && \
  pip wheel --wheel-dir=/build --find-links="https://wheel-index.linuxserver.io/${DISTRO}/" --no-cache-dir -v \
    ${PACKAGES}
