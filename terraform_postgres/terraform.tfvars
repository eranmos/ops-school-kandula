## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

#############  PostgreSQL Related  #############
rds_instance_name           = "kandula"
db_engine                   = "postgres"
db_engine_version           = "13.4"
db_parameter_group_name     = ""
db_option_group_name        = ""
bd_instance_class           = "db.t3.micro"
db_storage_type             = "gp2"
db_allocated_storage        = "20"
db_max_allocated_storage    = "100"
db_storage_encrypted        = "false"
db_name                     = "kandula"
db_username                 = "eranmos"
db_password                 = "123456789!"
db_port                     = "5432"
db_multi_az                 = "false"
db_maintenance_window       = "Sat:00:00-Sat:03:00"
db_backup_window            = "03:00-05:00"
db_publicly_accessible      = "true"
db_iam_authentication       = "false"
ca_cert_identifier          = "null"
db_availability_zone        = "us-east-1a"
allow_major_version_upgrade = false
auto_minor_version_upgrade  = true
apply_immediately           = true
deletion_protection         = false
delete_automated_backups    = true
backup_retention_period     = 5

#############  Tags Related  #############
environment_name = "ops-school"
owner            = "Eran Moshayov"
project_name     = "kandula"
asset_owner      = "moshayov.eran@refinitiv.com"
environment      = "Development"
asset_id         = "205126"