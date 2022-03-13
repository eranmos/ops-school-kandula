#############
# Variables #
#############
#############  aws cli  #############
variable "aws_cli_profile" {
  description = "AWS cli profile name"
  type        = string
}

#############  VPC Related  #############
variable "aws_region" {
  description = "AWS region"
  type        = string
}

#############  Jenkins Server  #############
variable "jenkins_master_name" {
  description = "The of the Jenkins-master instance"
  type        = string
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instance"
  type        = string
}

variable "jenkins_instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  type        = string
}

variable "jenkins_master_ami" {
  description = "The ami of the jenkins-master server"
  type        = string
}

variable "consul_server" {
  description = "The true of false value, if consul server need to be install value should be true"
  type        = string
}

variable "docker_engine" {
  description = "True of false value,If docker engine installed "
  type        = bool
}

#############  EBS ROOT Storage  #############
variable "ebs_root_encrypted" {
  description = "if ebs should be encrypted true or false values"
  type        = string
}

variable "ebs_root_volume_type" {
  description = "EBS volume type like gp2..."
  type        = string
}

variable "ebs_root_volume_size" {
  description = "EBS volume size in G"
  type        = string
}

variable "ebs_root_delete_on_termination" {
  description = "if need to delete this EBS device with terminating instance true or false values"
  type        = string
}

variable "ebs_jenkis_master_volume_id" {
  description = "The EBS volume ID"
  type        = string
}

variable "ebs_device_name" {
  description = "Name of the device to mount."
  type        = string
}

#############  Jenkins Slave  #######
variable "jenkins_slave_name" {
  description = "The of the Jenkins-slave instance"
  type        = string
}

variable "jenkins_slave_instances_count" {
  description = "numbers of Jenkins-slaves servers"
  type        = string
}

variable "jenkins_slave_ami" {
  description = "The ami of the jenkins-slave server"
  type        = string
}

variable "ubuntu_account_number" {
  description = "The AMI OS type of Jenkins-slave"
  type        = string
}

variable "ebs_root_volume_size_jenkins_slave" {
  description = "EBS root volume size in G"
  type        = string
}

variable "monitoring_bucket_name" {
  description = "AWS S3 Bucket name"
  type        = string
}

variable "monitoring_bucket_prefix" {
  description = "The name of the folder that will store LB logs"
  type        = string
}

#############  Route53  #############
variable "aws_registered_domains" {
  description = "my aws registered domains "
  type        = string
}

variable "jenkins_dns" {
  description = "my aws registered domains "
  type        = string
}

#############  S3  ########################
variable "default_s3_bucket" {
  description = "AWS s3 bucket for provisioning "
  type        = string
}

#############  Tags Related  #############
variable "asset_owner" {
  description = "Email, preferably distribution list of the project"
  type        = string
}

variable "environment" {
  description = "Environment i.e DEV, QA, PPE, PROD"
  type        = string
}

variable "asset_id" {
  description = "Asset insight of the project"
  type        = string
}

variable "environment_name" {
  description = "The name of the Environment i.e"
  type        = string
}

variable "owner" {
  description = "Full Name of the owner"
  type        = string
}

variable "project_name" {
  description = "The Name of the Project"
  type        = string
}