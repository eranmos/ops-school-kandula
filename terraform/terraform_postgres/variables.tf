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
#############  PostgreSQL  #############
variable "rds_instance_name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "The database engine to use (postgres,mysqal,mariadb...)"
  type        = string
}

variable "db_engine_version" {
  description = "The database engine version to use"
  type        = string
}

variable "db_parameter_group_name" {
  description = "The family of the database parameter group"
  type        = string
}

variable "db_option_group_name" {
  description = "The Name of the Option"
  type        = string
}

variable "bd_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
}

variable "db_max_allocated_storage" {
  description = "The Max database storage in gigabytes"
  type        = string
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially "
  type        = string
}

variable "db_username" {
  description = "Username for the master database user"
  type        = string
}

variable "db_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  type        = string
}

variable "db_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = string
}

variable "db_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
}

variable "db_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
}

variable "db_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = string
}

variable "db_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = string
}

variable "db_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD),"
  type        = string
}

variable "db_iam_authentication" {
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  type        = string
}

variable "ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  type        = string
}

variable "db_availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  type        = bool
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