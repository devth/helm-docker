FROM alpine

MAINTAINER Trevor Hartman <trevorhartman@gmail.com>

WORKDIR /

# Enable SSL
RUN apk --update add ca-certificates wget python

# Install gcloud and kubectl
# kubectl will be available at /google-cloud-sdk/bin/kubectl
ENV HOME /
ENV PATH /google-cloud-sdk/bin:$PATH
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --additional-components app kubectl alpha beta
# Disable updater check for the whole installation.
# Users won't be bugged with notifications to update to the latest version of gcloud.
RUN google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true

# Install Helm
ENV VERSION canary
ENV FILENAME helm-${VERSION}-linux-amd64.tar.gz
ADD https://kubernetes-helm.storage.googleapis.com/${FILENAME} /tmp
RUN tar -zxvf /tmp/${FILENAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && rm -rf /tmp
