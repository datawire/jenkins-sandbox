FROM jenkinsci/jenkins:2.54-alpine
MAINTAINER Datawire.io <dev@datawire.io>
LABEL PROJECT_REPO_URL="git@github.com:datawire/jenkins-docker.git" \
      PROJECT_REPO_BROWSER_URL="https://github.com/datawire/jenkins-docker" \
      DESCRIPTION="Datawire Jenkins Image" \
      VENDOR="Datawire" \
      VENDOR_URL="https://datawire.io/"

# Install OS dependecies using the root user.
USER root

ADD https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN apk add --no-cache \
        busybox-suid \
        ca-certificates \
        curl \
        docker \
    && chmod +x /usr/local/bin/kubectl \
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
