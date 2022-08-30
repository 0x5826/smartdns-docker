FROM debian:bullseye-slim AS builder

ARG TAG
ARG REPOSITORY

RUN apt update && apt install -y git make gcc libssl-dev

WORKDIR /root

RUN ARCH=$(dpkg --print-architecture) \
    && case "$ARCH" in \
    "amd64") \
        BUILD_TARGET="x86-64" \
        ;; \
    "arm64") \
        BUILD_TARGET="arm64" \
        ;; \
    *) \
        echo "Doesn't support $ARCH architecture" \
        exit 1 \
        ;; \
    esac \
    && git clone https://github.com/${REPOSITORY} smartdns \
    && cd smartdns \
    && git fetch --all --tags \
    && git checkout tags/${TAG} \
    && sh package/build-pkg.sh --platform linux --arch $BUILD_TARGET --static \
    && strip -s src/smartdns && cp src/smartdns /usr/bin

FROM alpine:latest

LABEL maintainer="dante"

COPY --from=builder /usr/bin/smartdns /usr/bin/smartdns

ENV TZ Asia/Shanghai

RUN apk update --no-cache && apk add --no-cache tzdata ca-certificates && apk upgrade --no-cache

RUN wget https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/main/gfwlist2smartdns/blacklist_full.conf -O /root/blacklist_full.conf
RUN wget https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/main/gfwlist2smartdns/whitelist_full.conf -O /root/whitelist_full.conf

ADD entrypoint.sh /root
ADD smartdns.conf /root
RUN chmod a+x /root/entrypoint.sh

VOLUME /etc/smartdns
WORKDIR /etc/smartdns

EXPOSE 53/udp 
EXPOSE 53/tcp

HEALTHCHECK --interval=5s --timeout=10s CMD nslookup -querytype=A www.baidu.com 127.0.0.1 | sed -n '6,7p' || exit 1

ENTRYPOINT ["/root/entrypoint.sh"]
