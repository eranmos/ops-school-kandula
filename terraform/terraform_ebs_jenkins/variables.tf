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

#############  EBS Storage  #############
variable "ebs_encrypted" {
  description = "if ebs should be encrypted true or false values"
  type        = string
}

variable "ebs_volume_type" {
  description = "EBS volume type like gp2..."
  type        = string
}

variable "ebs_volume_size" {
  description = "EBS volume size in G"
  type        = string
}

variable "ebs_multi_attach_enabled" {
  description = "Specifies whether to enable Amazon EBS Multi-Attach"
  type        = string
}

variable "ebs_device_name" {
  description = "Name of the device to mount."
  type        = string
}

variable "ebs_availability_zone" {
  description = "The availability zone of the ebs volume"
  type        = string
}

variable "ebs_volume_count_elasticsearch" {
  description = "numbers of ebs volumes for elasticsearch"
}

variable "ebs_volume_size_elasticsearch" {
  description = "EBS volume size in G"
  type        = string
}

variable "ebs_volume_count_prometheus" {
  description = "numbers of ebs volumes for prometheus"
}

variable "ebs_volume_size_prometheus" {
  description = "EBS volume size in G"
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