## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

#############  Consul Server  #############
key_name               = "eran_ops_school_keys"
consul_instance_type  = "t2.micro"
consul_instances_count = "3"
consul_server          = true
node_exporter          = true
ami                    = "ami-00ddb0e5626798373"

#EBS ROOT Volume config
ebs_root_delete_on_termination = true
ebs_root_encrypted             = true
ebs_root_volume_type           = "gp2"
ebs_root_volume_size           = "8"

#############  Elasticsearch Server  #############
elasticsearch_instances_count = "1"
elasticsearch_instance_type   = "t3.medium"
ebs_availability_zone         = "us-east-1a"
ebs_multi_attach_enabled      = "false"
ebs_encrypted                 = "true"
ebs_volume_size_elasticsearch = "10"
ebs_volume_type               = "gp2"
ebs_device_name               = "/dev/sdh"
docker_engine                 = false
elasticsearch_master          = true
elasticsearch_node            = true

ebs_elasticsearch_1_volume_id = ""
ebs_elasticsearch_2_volume_id = ""
ebs_elasticsearch_3_volume_id = ""

#############  Prometheus Server  #############
prometheus_instance_type    = "t3.medium"
ebs_prometheus_volume_id    = "vol-0c63aa9919ac50830"
ebs_volume_count_prometheus = "0"
ebs_volume_size_prometheus  = "10"

#############  Route53  #####################
aws_registered_domains = "kandula.click"
consul_dns             = "consul.kandula.click"
elasticsearch_dns      = "es.kandula.click"
kibana_dns             = "kibana.kandula.click"

#############  S3  #####################
default_s3_bucket                       = "eran-terraform-provisioning-bucket"
monitoring_bucket_name                  = "205126-kandula-monitoring-bucket"
monitoring_bucket_prefix                = "consul"
monitoring_bucket_prefix_elasticsearch  = "elasticsearch"
monitoring_bucket_prefix_kibana         = "kibana"
monitoring_bucket_prefix_prometheus     = "prometheus"


#############  Tags Related  #############
environment_name = "ops-school"
owner            = "Eran Moshayov"
project_name     = "kandula"
asset_owner      = "moshayov.eran@refinitiv.com"
environment      = "Development"
asset_id         = "205126"