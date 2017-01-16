FROM jenkinsci/jnlp-slave

USER root

## ===@TODO: Add required dependencies==

ARG HELM_VERSION=v2.1.3

RUN curl https://kubernetes-helm.storage.googleapis.com/helm-$HELM_VERSION-linux-386.tar.gz | tar xz -C /tmp \
    && chmod 755 /tmp/linux-386/helm \
    && mv /tmp/linux-386/helm /usr/bin


## ====================================

USER jenkins

ADD helm.repo /tmp/helm.repo

RUN helm init -c  \
    && cat /tmp/helm.repo | xargs -n 2 helm repo add $1 $2 \
    && helm repo update \
    && helm repo list

