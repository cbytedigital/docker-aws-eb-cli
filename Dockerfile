FROM alpine

LABEL maintainer="devops@cbyte.nl"

# Install dependencies
RUN apk --no-cache --update add \
        bash \
        less \
        groff \
        jq \
        git \
        curl \
        gcc \
        make \
        rust \
        cargo \
        openssl-dev \
        musl-dev \
        libffi-dev \
        python3-dev \
        py3-pip

# Install latest version of AWS CLI and AWS EB CLI
RUN pip3 install --break-system-packages awsebcli awscli 

# Clean up caches to reduce size
RUN rm -rf /var/cache/apk/*

# Create default credentials folder
RUN mkdir ~/.aws
