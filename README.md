# smartdns-docker

docker for smartdns

## docker compose

```yaml
version: '3'
services:
  mosdns:
    image: 0x5826/smartdns:latest
    container_name: smartdns
    hostname: smartdns
    restart: always
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - "<HOST_DATA>/smartdns:/etc/smartdns"
    ports:
      - "53:53/tcp"
      - "53:53/udp"
```

## docker build command

```
$(which sudo) docker buildx build --push --build-arg VERSION=$(get_latest_tags.sh "pymumu/smartdns") --platform linux/arm64/v8,linux/amd64 -t harbor.duckduckfly.xyz/local/smartdns:latest -t harbor.duckduckfly.xyz/local/smartdns:$(get_latest_tags.sh "pymumu/smartdns") .
```
