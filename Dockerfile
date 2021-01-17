FROM alpine

# Install dependencies
RUN apk --no-cache --update add \
        bash \
        less \
        groff \
        jq \
        git \
        curl \
        python \
        py-pip \
        openssh-client

# Install latest version of AWS CLI and AWS EB CLI
RUN pip install --upgrade pip \
        awsebcli \
        awscli

# Create default credentials folder
RUN mkdir ~/.aws