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
