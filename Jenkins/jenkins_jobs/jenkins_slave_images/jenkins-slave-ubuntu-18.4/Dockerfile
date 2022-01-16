# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:18.04
MAINTAINER Eran Moshayov | DevOps Team | <eran.ops.school@gmail.com>

ENV DEBIAN_FRONTEND "noninteractive"
ENV HELMFILE_VERSION "0.125.5"
ENV TERRAFORM_VERSION "0.13.5"


# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
# Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 8 (latest stable edition at 2019-04-01)
    apt-get install -qy openjdk-8-jdk && \
# Install maven
    apt-get install -qy maven && \
## Install setuptools and aws-cli
    apt-get install -y python3-setuptools && \
    pip3 install setuptools wheel && pip3 install awscli ansible docker docker-compose boto boto3 botocore && \
## Install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl && \
## Install helm2 and helm3
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && mv /usr/local/bin/helm /usr/local/bin/helm3 && \
## Install aws-iam-authenticator
    curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/darwin/amd64/aws-iam-authenticator && chmod +x /usr/local/bin/aws-iam-authenticator && \
# Clean apt cache
    apt-get -qy autoremove && \
# Add user jenkins to the image
    adduser --quiet jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:jenkins" | chpasswd

# Copy authorized keys
COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]