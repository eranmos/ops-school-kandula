## AWS CLI Profile
aws_cli_profile = "tr-tms"

## AWS account data
aws_region      = "us-east-1"

#############  Opensearch Related  #############
elasticsearch_version           = "7.10"
elasticsearch_instance_type     = "t3.small.elasticsearch"
elasticsearch_instance_count    = "1"
automated_snapshot_start_hour   = "23"
elasticsearch_ebs_volume_size   = "50"
elasticsearch_ebs_volume_type   = "gp2"
custom_endpoint_enabled         = "true"
elasticsearch_enforce_https     = "true"
tls_security_policy             = "Policy-Min-TLS-1-2-2019-07"
es_logging_encrypt_at_rest      = true

#############  Route53  #####################
aws_registered_domains  = "kandula.click"
elasticsearch_dns       = "kibana.kandula.click"

#############  Tags Related  #############
environment_name = "ops-school"
owner            = "Eran Moshayov"
project_name     = "kandula"
asset_owner      = "moshayov.eran@refinitiv.com"
environment      = "Development"
asset_id         = "205126"