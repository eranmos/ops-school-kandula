## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

#############  Jenkins Slave  ##############
jenkins_slave_name            = "jenkins-slave"
jenkins_slave_instances_count = "1"
jenkins_slave_ami             = "ami-00ddb0e5626798373"
ubuntu_account_number         = "099720109477"
jenkins_instance_type         = "t2.micro"
consul_server                 = "false"
key_name                      = "eran_ops_school_keys"

#EBS ROOT Volume config
ebs_root_delete_on_termination     = "true"
ebs_root_encrypted                 = "true"
ebs_root_volume_type               = "gp2"
ebs_root_volume_size               = "8"

#EBS Jenkins Volume
ebs_jenkis_master_volume_id        = "vol-088dbb43ce8754096"
ebs_device_name               = "/dev/sdh"

#############  Route53  #####################
aws_registered_domains = "kandula.click"
jenkins_dns            = "jenkins.kandula.click"

#############  S3  #####################
default_s3_bucket = "eran-terraform-provisioning-bucket"

#############  Tags Related  #############
environment_name = "ops-school"
owner            = "Eran Moshayov"
project_name     = "kandula"
asset_owner      = "moshayov.eran@refinitiv.com"
environment      = "Development"
asset_id         = "205126"