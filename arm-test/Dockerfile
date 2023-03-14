FROM bash:latest as builder
FROM alpine/git:latest-armv7

COPY --from=builder /usr/local/bin/bash /bin/bash
COPY entrypoint.sh /tmp/entrypoint.sh

RUN mkdir -p /app

WORKDIR /app

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
