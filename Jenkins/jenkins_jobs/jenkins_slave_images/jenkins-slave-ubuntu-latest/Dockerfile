# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
## Image contains:
## unzip curl vim libltdl7 openjdk-8-jre openssh-server git bzip2 build-essential python3 python3-pip locales gnupg rsync iputils-ping netcat-openbsd jq groff less jfrogcli awscli helm2 helm3
FROM ubuntu:latest
MAINTAINER Eran Moshayov | DevOps Team | <eran.ops.school@gmail.com>

ENV DEBIAN_FRONTEND "noninteractive"
ENV HELMFILE_VERSION "3.2.1"
ENV TERRAFORM_VERSION "1.1.2"

ARG docker_gid=896
ARG docker_group=docker
ARG user=jenkins
ARG group=jenkins
ARG uid=67334
ARG gid=62084

ENV JENKINS_HOME=/home/${user} \
    TZ='Asia/Jerusalem' \
    APT_PACKAGES="unzip curl vim libltdl7 openjdk-8-jre openssh-server sshpass tree git bzip2 build-essential python3 python3-pip python locales gnupg rsync iputils-ping netcat-openbsd jq groff less"

RUN \
## Packages upgrade & Installations
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils &&  \
    apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends && \
    apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends ${APT_PACKAGES} && locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales && \
## Install git-lfs
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
## Install setuptools ansible & aws-cli
    apt-get install -y python3-setuptools && \
    pip3 install setuptools wheel && pip3 install awscli ansible docker docker-compose boto boto3 botocore && \
    ansible-galaxy collection install amazon.aws && \
## Install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl && \
## Install helm3
##    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash && \
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && mv /usr/local/bin/helm /usr/local/bin/helm3 && \
## Install aws-iam-authenticator
    curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/darwin/amd64/aws-iam-authenticator && chmod +x /usr/local/bin/aws-iam-authenticator && \
## Clean apt cache
    apt-get -q autoremove && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin && \
## Add jenkins user
    groupadd -g ${gid} ${group} && \
    useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user} && \
    echo "${user}:jeHUpiQyujqIY" | chpasswd -e && \
    echo "root:ro.wFwZaBEgbg" | chpasswd -e && \
## Add docker group
    groupadd -g ${docker_gid} ${docker_group} && adduser ${user} ${docker_group} && \
## Add alias to bashrc
    echo "alias ll='ls -laht'" >> /home/${user}/.bashrc && \
## Add links to /data folder
    mkdir -p /run/systemd && echo 'docker' > /run/systemd/container  && \
## Create ssh directories
    mkdir -p /var/run/sshd && \
    mkdir -p "$JENKINS_HOME"/.ssh && \
## Create Anible directories
    mkdir -p /etc/ansible/inventory/ && \
    mkdir -p /etc/ansible/inventory/group_vars/ && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
#Set Encoding
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE C.UTF-8
## Add .gitconfig file & docker login repo credentials & .ssh keys
ADD --chown=jenkins:jenkins ./conf/. /home/${user}
## Add Ansible config files
ADD --chown=jenkins:jenkins ./conf/.ansible/ansible.cfg /etc/ansible/
## Add inventory  files
ADD --chown=jenkins:jenkins ./conf/.ansible/aws_ec2.yaml /etc/ansible/inventory/
## Add Ansible config files
ADD --chown=jenkins:jenkins ./conf/.ansible/all.yaml /etc/ansible/inventory/group_vars/
## Set appropriate permissons for .ssh
RUN chown -R ${user}:${group} /home/jenkins/.ssh && chmod 700 /home/jenkins/.ssh && chmod 600 /home/jenkins/.ssh/*
## Appropriate permissions
EXPOSE 22
## Define working directory
WORKDIR /home/${user}
## Start SSH service as Daemon
CMD ["/usr/sbin/sshd", "-D"]
