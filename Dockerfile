FROM alpine:3.2
MAINTAINER XaMoC <maxime.cottret@gmail.com>

ENV NOMAD_VERSION 0.1.2

RUN apk add --update wget ca-certificates bash curl && \
  curl -o glibc-2.21-r2.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" && \
  apk add --allow-untrusted glibc-2.21-r2.apk && \
  curl -o glibc-bin-2.21-r2.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" && \
  apk add --allow-untrusted glibc-bin-2.21-r2.apk && \
  /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
  apk del curl && \
  rm -f glibc-2.21-r2.apk glibc-bin-2.21-r2.apk && \
  rm -rf /var/cache/apk/*

RUN mkdir /etc/nomad.d
RUN chmod a+w /etc/nomad.d
RUN wget -qO- -O nomad.zip https://dl.bintray.com/mitchellh/nomad/nomad_${NOMAD_VERSION}_linux_amd64.zip --no-check-certificate && \
    unzip -d /usr/bin/ nomad.zip && rm nomad.zip
RUN chmod +x /usr/bin/nomad
