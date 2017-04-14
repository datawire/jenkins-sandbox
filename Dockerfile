FROM jenkinsci/jenkins:2.54-alpine
MAINTAINER Datawire.io <dev@datawire.io>
LABEL PROJECT_REPO_URL="git@github.com:datawire/jenkins-docker.git" \
      PROJECT_REPO_BROWSER_URL="https://github.com/datawire/jenkins-docker" \
      DESCRIPTION="Datawire Jenkins Image" \
      VENDOR="Datawire" \
      VENDOR_URL="https://datawire.io/"

ENV KUBECTL_VERSION "1.6.1"
ENV KOPS_VERSION "1.5.3"

# Install OS dependecies using the root user.
USER root

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 /usr/local/bin/kops

RUN apk add --no-cache \
        busybox-suid \
        ca-certificates \
        curl \
        docker \
    && chmod +x /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kops \
    && addgroup jenkins docker

COPY security-basic.groovy \
     executors.groovy \
     /usr/share/jenkins/ref/init.groovy.d/

RUN /usr/local/bin/install-plugins.sh \
    bitbucket \
    blueocean \
    credentials-binding \
    custom-tools-plugin \
    docker-workflow \
    envinject \
    kubernetes \
    pipeline-maven \
    slack \
    xunit

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
