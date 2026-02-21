# 构建时
FROM docker.io/library/golang:latest AS builder
ARG REPO
# eg. amd64 | arm64
ARG ARCH
# eg. x86_64 | aarch64
ARG CPU_ARCH
ARG TAG
# eg. latest
ARG IMAGE_VERSION
ENV REPO=$REPO \
     ARCH=$ARCH \
     CPU_ARCH=$CPU_ARCH \
     TAG=$TAG \
     IMAGE_VERSION=$IMAGE_VERSION

ENV CADDY_VERSION=$TAG

WORKDIR /
RUN apt-get update && apt-get install -y --no-install-recommends upx debian-keyring debian-archive-keyring apt-transport-https libcap2-bin
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-xcaddy-archive-keyring.gpg && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-xcaddy.list
RUN apt-get update && apt-get install -y --no-install-recommends xcaddy
WORKDIR /output/
RUN CADDY_VERSION=$TAG XCADDY_SETCAP=0 XCADDY_SUDO=0 xcaddy build --output caddy

# 运行时
FROM scratch AS runtime
COPY rootfs/ /
COPY --from=builder /output/caddy /usr/sbin/caddy