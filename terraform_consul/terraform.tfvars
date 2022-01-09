## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

#############  Consul Server  #############
key_name               = "eran_ops_school_keys"
consul_instance_type  = "t2.micro"
consul_instances_count = "3"
consul_server          = "true"
ami                    = "ami-00ddb0e5626798373"

#############  Route53  #####################
aws_registered_domains = "kandula.click"
consul_dns            = "consul.kandula.click"

#############  S3  #####################
default_s3_bucket = "eran-terraform-provisioning-bucket"

#############  Tags Related  #############
environment_name = "ops-school"
owner            = "Eran Moshayov"
project_name     = "kandula"
asset_owner      = "moshayov.eran@refinitiv.com"
environment      = "Development"
asset_id         = "205126"