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

#############  EKS  ########################
variable "cluster_private_endpoint" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
}

variable "instance_type" {
  description = "Kubernetes instance type for worker nodes"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum worker capacity in the autoscaling group. NOTE: Change in this paramater will affect the asg_desired_capacity, like changing its value to 2 will change asg_desired_capacity value to 2 but bringing back it to 1 will not affect the asg_desired_capacity"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum worker capacity in the autoscaling group"
  type        = number
}

variable "asg_size" {
  description = "Number of nodes for Kubernetes"
  type        = number
}

variable "ami" {
  description = "The AMI (ubuntu 18) that I would like to use for consul"
  type        = string
}

variable "root_encrypted" {
  description = "Whether the worker volume should be encrypted or not"
  type        = bool
}

variable "root_volume_size" {
  description = "Root volume size of workers instances"
  type        = number
}

variable "cluster_irsa" {
  description = "Enable IRSA for EKS cluster"
  type        = bool
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