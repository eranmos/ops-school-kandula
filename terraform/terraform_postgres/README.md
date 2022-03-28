<h1 align="center">Terraform RDS PostgreSQL </h1>

<h6 align="center">Terraform which creates Postgres DB resources on AWS (RDS).</h6>

## Table of Contents

- [Prerequisites](#prerequisites)
- [Deploying Instructions](#deploying-instructions)
- [Variables References Table](#variables-references-table)
- [Data Flow Table](#data-flow-table)

## Prerequisites
To deploy all infrastructure you will need below application to be installed on your workstation/server
+ Install [GIT](https://github.com/git-guides/install-git) on your workstation/server
+ Install [Terraform v1.1.2](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server


## Deploying Instructions

  Run the following:
   ```bash
   terraform init
   terraform apply --auto-approve
   ```

## Variables References Table

In below table you can see `variables.tf` file details:

| Variable | Type | Description |
| -------- | ---- | ----------- |
| aws_cli_profile | string | your awscli profile config |
| aws_region | string | AWS working region |
| rds_instance_name | string | The name of the RDS instance |
| db_engine | string | The database engine to use (postgres,mysqal,mariadb...)|
| db_engine_version | string | The database engine version to use |
| db_parameter_group_name | string | The family of the database parameter group |
| db_option_group_name | string | The Name of the Option |
| bd_instance_class | string | The instance type of the RDS instance |
| db_allocated_storage | string | The Max database storage in gigabytes |
| db_name | string | The DB name to create. If omitted, no database is created initially |
| db_username | string | Username for the master database user |
| db_password | string | Password for the master DB user |
| db_port | string | The port on which the DB accepts connections |
| db_multi_az | string | Specifies if the RDS instance is multi-AZ |
| db_maintenance_window | string | The window to perform maintenance |
| db_backup_window | string | The daily time range for DB Backup|
| db_publicly_accessible | bool | Bool to control if instance is publicly accessible |
| db_storage_encrypted | string | Specifies whether the DB instance is encrypted |
| db_storage_type | string | One of 'standard' (magnetic), 'gp2' (general purpose SSD) |
| db_iam_authentication | string | Specifies whether or not the mappings of AWS Identity|
| ca_cert_identifier | string | Specifies the identifier of the CA certificate|
| db_availability_zone | string | The Availability Zone of the RDS instance |
| allow_major_version_upgrade | bool | Indicates that major version upgrades are allowed |
| auto_minor_version_upgrade | bool | Indicates that minor engine upgrades will be applied automatically |
| apply_immediately | bool | Specifies whether any database modifications are applied immediately |
| backup_retention_period | number | The days to retain backups for |
| deletion_protection | bool | The database can't be deleted when this value is set to true |
| delete_automated_backups | bool | Specifies whether to remove automated backups immediately after the DB instance is deleted |
| asset_owner | string  | tag - Email, preferably distribution list of the project |
| environment | string | tag - Environment i.e DEV, QA, PPE, PROD |
| asset_id | string | tag - Asset insight of the project |
| environment_name | string | tag - The name of the Environment i.e |
| owner | string |tag - Full Name of the owner |
| project_name | string| tag - The Name of the Project |

## Data Flow Table

### PostgreSQL:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| PostgreSQL to outside | PostgreSQL | * | * | * | * |
| PostgreSQL DB | * | * | PostgreSQL | 5432 | TCP |