## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

#############  AWS EKS  #############
kubernetes_version  = "1.19"
cluster_irsa        = true
instance_type       = "t2.small"
asg_min_size        = 2
asg_max_size        = 4
asg_size            = 2
ami                 = "ami-00ddb0e5626798373"
root_encrypted      = true
root_volume_size    = 8



#############  Route53  #####################


#############  S3  #####################
default_s3_bucket = "eran-terraform-provisioning-bucket"

#############  Tags Related  #############
environment_name = "ops-school"
owner            = "Eran Moshayov"
project_name     = "kandula"
asset_owner      = "moshayov.eran@refinitiv.com"
environment      = "Development"
asset_id         = "205126"