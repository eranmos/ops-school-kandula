#############
# Variables #
#############
#############  aws cli  #############
variable "aws_cli_profile" {
  description = "AWS cli profile name"
  type        = string
}

variable "account_id" {
  description = "Account id of AWS account"
  type        = string
}

#############  VPC Related  #############
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ubuntu_account_number" {
  default = "099720109477"
}

#############  EKS  #############
variable "kubernetes_version" {
  description = "kubernetes version"
  type        = string
}

variable "cluster_irsa" {
  description = "Enable IRSA for EKS cluster"
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

variable "ebs_driver" {
  description = "Indicate installation for AWS EBS Driver"
  type        = bool
}

variable "aws_load_balancer_controller" {
  description = "Indicate installation for AWS LB"
  type = bool
}

variable "ingress_namespace" {
  description = "Namespace name for Ingress Controller"
  type        = string
}

variable "logging_namespace" {
  description = "Namespace name for Logging Namespace"
  type        = string
}

variable "monitoring_namespace" {
  description = "Namespace name for Monitoring System"
  type        = string
}

variable "external_dns_namespace" {
  description = "Namespace name for External DNS"
  type        = string
}

variable "external_dns" {
  description = "Indicate installation External-DNS solution"
  type        = bool
}



#############  Route53  #############


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