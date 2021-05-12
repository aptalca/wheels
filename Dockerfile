ARG DISTRO
ARG DISTROVER
ARG ARCH

FROM ghcr.io/linuxserver/baseimage-${DISTRO}:${ARCH}-${DISTROVER}

RUN \
  if [ -f /usr/bin/apt ]; then \
    echo "**** Detected Ubuntu ****" && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
      cargo \
      libffi-dev \
      libssl-dev \
      python3-dev \
      python3-pip; \
  else \
    echo "**** Detected Alpine ****" && \
    apk add --no-cache \
      cargo \
      g++ \
      gcc \
      libffi-dev \
      openssl-dev \
      py3-pip \
      python3-dev; \
  fi && \
  echo "**** Updating pip and building wheels ****" && \
  pip3 install -U pip setuptools wheel && \
  mkdir -p /build && \
  pip wheel --wheel-dir=/build --find-links=/build --no-cache-dir \
    cryptography
  
    
