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

#############  VPC Related  #############
variable "availablity_zone_a" {
  description = "AWS availability one A"
  type        = string
}

variable "availablity_zone_b" {
  description = "AWS availability one B"
  type        = string
}

variable "private_dns_name" {
  description = "My private DNS name"
  type        = string
}

#############  Network  #############
variable "network_address_space" {
  description = "My VPC CIDER"
  type        = string
}
variable "public_subnet1_address_space" {
  description = "My public subnet 1"
  type        = string
}
variable "private_subnet1_address_space" {
  description = "My private subnet 1"
  type        = string
}
variable "public_subnet2_address_space" {
  description = "My public subnet 2"
  type        = string
}
variable "private_subnet2_address_space" {
  description = "My private subnet 2"
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