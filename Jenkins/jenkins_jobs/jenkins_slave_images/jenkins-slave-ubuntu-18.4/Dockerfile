# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
## Image contains:
## unzip curl vim openjdk-8-jdk git bzip2 python python-pip python3 python3-pip awscli helm3 ansible
FROM ubuntu:18.04
MAINTAINER Eran Moshayov | DevOps Team | <eran.ops.school@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
    apt-get install -y curl && \
    apt-get install -y vim && \
    apt-get install -y unzip && \
# Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 8 (latest stable edition at 2019-04-01)
    apt-get install -qy openjdk-8-jdk && \
# Install maven
    apt-get install -qy maven && \
# Install Python
    apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    apt-get install -y python && \
    apt-get install -y python-pip && \
## Install setuptools and aws-cli
    apt-get install -y python3-setuptools && \
    pip3 install setuptools wheel && pip3 install awscli docker docker-compose boto boto3 botocore && \
    pip install boto3 botocore && \
## Install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl && \
## Install helm3
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
## Install aws-iam-authenticator
    curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/darwin/amd64/aws-iam-authenticator && chmod +x /usr/local/bin/aws-iam-authenticator && \
## Install Ansible
    apt-get install -y software-properties-common && \
    add-apt-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible && \
    ansible-galaxy collection install amazon.aws && \
    ansible-galaxy collection install community.docker && \
## Install Trivy (Vulnerability Tool)
    sudo apt-get install wget apt-transport-https gnupg lsb-release \
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add - \
    echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list \
    sudo apt-get update \
    sudo apt-get install trivy \

# Cleanup old packages
    apt-get -qy autoremove && \
# Add user jenkins to the image
    adduser --quiet jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2 && \
    mkdir -p /etc/ansible/inventory/ && \
    mkdir -p /etc/ansible/inventory/group_vars/


# Copy authorized keys
COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys
## Add Ansible config files
ADD --chown=jenkins:jenkins ./conf/.ansible/ansible.cfg /etc/ansible/
## Add inventory  files
ADD --chown=jenkins:jenkins ./conf/.ansible/aws_ec2.yaml /etc/ansible/inventory/
## Add Ansible config files
ADD --chown=jenkins:jenkins ./conf/.ansible/all.yaml /etc/ansible/inventory/group_vars/

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]