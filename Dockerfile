FROM bash:latest as builder
FROM alpine/git:latest-amd64

COPY --from=builder /usr/local/bin/bash /bin/bash

RUN mkdir -p /app

COPY entrypoint.sh /tmp/entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
