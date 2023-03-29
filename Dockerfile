FROM alpine:latest
LABEL maintainer="Ryan Schlesinger <ryan@ryanschlesinger.com>"

ENV FIXUID_VERSION 0.5.1

SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN set -eux; \
      \
      apk add --no-cache ca-certificates curl; \
      USER=deploy; \
      GROUP=deploy; \
      curl -SsL https://github.com/boxboat/fixuid/releases/download/v${FIXUID_VERSION}/fixuid-${FIXUID_VERSION}-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf -; \
      chown root:root /usr/local/bin/fixuid; \
      chmod 4755 /usr/local/bin/fixuid; \
      mkdir -p /etc/fixuid; \
      printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml
