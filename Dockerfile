FROM alpine/git:latest

RUN mkdir -p /app

COPY entrypoint.sh /tmp/entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/tmp/entrypoint.sh"]
