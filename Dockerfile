FROM google/cloud-sdk

MAINTAINER Trevor Hartman <trevorhartman@gmail.com>

ENV VERSION v2.0.0-alpha.3

WORKDIR /

ADD https://github.com/kubernetes/helm/releases/download/${VERSION}/helm-${VERSION}-linux-amd64.tar /tmp

COPY helm_install_or_upgrade /bin/

RUN tar -xf /tmp/helm-${VERSION}-linux-amd64.tar -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && rm -rf /tmp
