####################
#    opensearch    #
####################

resource "aws_elasticsearch_domain" "es" {
  domain_name           = local.elasticsearch_cluster_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type  = var.elasticsearch_instance_type
    instance_count = var.elasticsearch_instance_count
  }
  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }
#  vpc_options {
#    subnet_ids = [data.aws_subnet.public-us-east-1a.id]
#    security_group_ids = [aws_security_group.elasticsearch.id]
#  }

  ebs_options {
    ebs_enabled = var.elasticsearch_ebs_volume_size > 0 ? true : false
    volume_size = var.elasticsearch_ebs_volume_size
    volume_type = var.elasticsearch_ebs_volume_type
  }

  encrypt_at_rest {
    enabled = var.es_logging_encrypt_at_rest
  }

  domain_endpoint_options {
    custom_endpoint_certificate_arn  = data.aws_acm_certificate.issued.arn
    custom_endpoint_enabled          = var.custom_endpoint_enabled
    custom_endpoint                  = var.elasticsearch_dns
    enforce_https                    = var.elasticsearch_enforce_https
    tls_security_policy              = var.tls_security_policy
  }

  tags = {
    Owner                             = local.eran_tags.owner
    Environment_Name                  = local.eran_tags.environment_name
    Project_Name                      = local.eran_tags.project_name
    "tr:resource-owner"               = var.asset_owner
    "tr:environment-type"             = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}