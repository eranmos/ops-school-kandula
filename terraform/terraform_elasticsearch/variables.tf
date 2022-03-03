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

#############  opensearch Related  #############

variable "elasticsearch_version" {
  description = "The version of the elasticsearch."
  type        = string
}

variable "elasticsearch_instance_type" {
  description = "The instance type of the elasticsearch."
  type        = string
}

variable "elasticsearch_instance_count" {
  description = "(Optional) Number of dedicated main nodes in the cluster."
  type        = string
}

variable "automated_snapshot_start_hour" {
  description = "(Required) Hour during which the service takes an automated daily snapshot of the indices in the domain."
  type        = string
}

variable "elasticsearch_ebs_volume_size" {
  description = "(Required if ebs_enabled is set to true.) Size of EBS volumes attached to data nodes (in GiB)."
  type        = string
}

variable "elasticsearch_ebs_volume_type" {
  description = "(Optional) Type of EBS volumes attached to data nodes."
  type        = string
}

variable "custom_endpoint_enabled" {
  description = "(Optional) Whether to enable custom endpoint for the Elasticsearch domain."
  type        = string
}

variable "elasticsearch_enforce_https" {
  description = "(Optional) Whether or not to require HTTPS."
  type        = bool
}

variable "tls_security_policy" {
  description = "(Optional) Name of the TLS security policy that needs to be applied to the HTTPS endpoint."
  type        = string
}

variable "es_logging_encrypt_at_rest" {
  description = "Elasticsearch encrypt"
  type        = bool
}

#############  Route53  #############
variable "aws_registered_domains" {
  description = "my aws registered domains "
  type        = string
}

variable "elasticsearch_dns" {
  description = "my A name record for elasticsearch DNS "
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
