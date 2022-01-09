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