FROM ubuntu:20.04

RUN apt-get -yq update && \
  apt-get -yq upgrade && \
  apt-get install -yq --no-install-recommends git && \
  apt-get clean

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
