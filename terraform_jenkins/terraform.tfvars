## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

#############  Jenkins Server  #############
jenkins_master_name   = "jenkins-master"
key_name              = "eran_ops_school_keys"
jenkins_instance_type = "t3.small"
jenkins_master_ami    = "ami-0251d3dff6fb31ebc"
consul_server         = "false"

#############  Jenkins Slave  ##############
jenkins_slave_name           = "jenkins-slave"
jenkins_slave_instances_count = "1"
jenkins_slave_ami             = "ami-0988936315f0207b1"
ubuntu_account_number         = "099720109477"

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