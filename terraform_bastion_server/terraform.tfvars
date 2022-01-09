## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

#############  Bastion Server  #############
bastion_instance_name  = "Bastion-Server"
key_name               = "eran_ops_school_keys"
bastion_instance_type  = "t2.micro"
consul_server          = "false"
ami                    = "ami-00ddb0e5626798373"

#############  S3  #####################
default_s3_bucket = "eran-terraform-provisioning-bucket"

#############  Tags Related  #############
environment_name = "ops-school"
owner            = "Eran Moshayov"
project_name     = "kandula"
asset_owner      = "moshayov.eran@refinitiv.com"
environment      = "Development"
asset_id         = "205126"