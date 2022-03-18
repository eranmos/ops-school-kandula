## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

############# Jenkins EBS Volume config #############
ebs_encrypted                 = "true"
ebs_volume_type               = "gp2"
ebs_volume_size               = "16"
ebs_multi_attach_enabled      = "false"
ebs_device_name               = "/dev/sdh"
ebs_availability_zone         = "us-east-1a"

############# elasticsearch EBS Volume config #######
ebs_volume_count_elasticsearch = "3"
ebs_volume_size_elasticsearch  = "10"

############# prometheus EBS Volume config #######
ebs_volume_count_prometheus = "1"
ebs_volume_size_prometheus  = "10"

#############  Tags Related  #############
environment_name = "ops-school"
owner            = "Eran Moshayov"
project_name     = "kandula"
asset_owner      = "moshayov.eran@refinitiv.com"
environment      = "Development"
asset_id         = "205126"