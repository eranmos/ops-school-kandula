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

#############  S3 Bucket Related  #############
variable "monitoring_bucket_name" {
  description = "AWS S3 Bucket name"
  type        = string
}

#############  Tags Related  #############

variable "asset_owner" {
  description = "Email, preferably destribution list of the project"
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
