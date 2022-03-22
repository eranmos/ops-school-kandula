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

#############  Consul Server  #######
variable "consul_server_name" {
  description = "The of the Jenkins-slave instance"
  type        = string
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instance"
  type        = string
}

variable "consul_instances_count" {
  description = "numbers of consul servers"
}

variable "consul_instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  type        = string
}

variable "ami" {
  description = "The AMI (ubuntu 18) that I would like to use for consul"
  type        = string
}

variable "consul_server" {
  description = "The true of false value, if consul server need to be install value should be true"
  type        = bool
}

#############  Elasticsearch Server  #######
variable "elasticsearch_server_name" {
  description = "The of the Jenkins-slave instance"
  type        = string
}


variable "elasticsearch_instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  type        = string
}

variable "elasticsearch_instances_count" {
  description = "numbers of elasticsearch servers"
}

variable "elasticsearch_master" {
  description = "True of false value,If docker engine installed "
  type        = bool
}

variable "elasticsearch_node" {
  description = "True of false value,If docker engine installed "
  type        = bool
}

#############  Prometheus Server  #######
variable "prometheus_server_name" {
  description = "The of the Jenkins-slave instance"
  type        = string
}

variable "prometheus_instances_count" {
  description = "numbers of consul servers"
}

variable "prometheus_instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  type        = string
}

variable "docker_engine" {
  description = "True of false value,If docker engine installed "
  type        = bool
}

variable "node_exporter" {
  description = "True of false value,If need to install node exporter "
  type        = bool
}

#############  EBS ROOT Storage  #############
variable "ebs_root_encrypted" {
  description = "if ebs should be encrypted true or false values"
  type        = bool
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
  type        = bool
}

variable "monitoring_bucket_name" {
  description = "AWS S3 Bucket name"
  type        = string
}

variable "monitoring_bucket_prefix" {
  description = "The name of the folder that will store LB logs"
  type        = string
}

variable "monitoring_bucket_prefix_elasticsearch" {
  description = "The name of the folder that will store LB logs"
  type        = string
}

variable "monitoring_bucket_prefix_kibana" {
  description = "The name of the folder that will store LB logs"
  type        = string
}

variable "monitoring_bucket_prefix_prometheus" {
  description = "The name of the folder that will store LB logs"
  type        = string
}

#############  EBS Storage  #############
variable "ebs_encrypted" {
  description = "if ebs should be encrypted true or false values"
  type        = string
}

variable "ebs_volume_type" {
  description = "EBS volume type like gp2..."
  type        = string
}

variable "ebs_multi_attach_enabled" {
  description = "Specifies whether to enable Amazon EBS Multi-Attach"
  type        = string
}

variable "ebs_availability_zone" {
  description = "The availability zone of the ebs volume"
  type        = string
}

variable "ebs_device_name" {
  description = "Name of the device to mount."
  type        = string
}

variable "ebs_volume_size_elasticsearch" {
  description = "EBS volume size in G"
  type        = string
}

variable "ebs_volume_size_prometheus" {
  description = "EBS volume size in G"
  type        = string
}

#############  Route53  #############
variable "aws_registered_domains" {
  description = "my aws registered domains "
  type        = string
}

variable "consul_dns" {
  description = "my A name record for consul DNS "
  type        = string
}

variable "elasticsearch_dns" {
  description = "my A name record for ES DNS "
  type        = string
}

variable "kibana_dns" {
  description = "my A name record for Kibana DNS "
  type        = string
}

variable "prometheus_dns" {
  description = "my A name record for prometheus DNS "
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