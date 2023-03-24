FROM debian:bullseye-slim AS builder

ARG VERSION

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
    && git clone https://github.com/pymumu/smartdns smartdns \
    && cd smartdns \
    && git fetch --all --tags \
    && git checkout tags/${VERSION} \
    && sh package/build-pkg.sh --platform linux --arch $BUILD_TARGET --static \
    && strip -s src/smartdns && cp src/smartdns /usr/bin

FROM alpine:latest

LABEL maintainer="dante"

COPY --from=builder /usr/bin/smartdns /usr/bin/smartdns

ENV TZ Asia/Shanghai

RUN apk update --no-cache && apk add --no-cache tzdata ca-certificates curl && apk upgrade --no-cache

WORKDIR /root
ADD smartdns.conf /root
ADD init_rules.sh /root
ADD entrypoint.sh /root
RUN chmod a+x /root/init_rules.sh && \
    chmod a+x /root/entrypoint.sh && \
    sh /root/init_rules.sh

VOLUME /etc/smartdns
WORKDIR /etc/smartdns

EXPOSE 53/udp 
EXPOSE 53/tcp

HEALTHCHECK --interval=30s --timeout=3s CMD nslookup -querytype=A www.baidu.com 127.0.0.1 | sed -n '6,7p' || exit 1

ENTRYPOINT ["/root/entrypoint.sh"]
