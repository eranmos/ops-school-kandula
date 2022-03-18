resource "aws_ebs_volume" "jenkins_master_data_volume" {
  availability_zone         = var.ebs_availability_zone
  multi_attach_enabled      = var.ebs_multi_attach_enabled
  encrypted                 = var.ebs_encrypted
  size                      = var.ebs_volume_size
  type                      = var.ebs_volume_type


  tags = {
    Name = "jenkins_master_volume"
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }

}

resource "aws_ebs_volume" "elasticsearch_data_volume" {
  count                     = var.ebs_volume_count_elasticsearch
  availability_zone         = var.ebs_availability_zone
  multi_attach_enabled      = var.ebs_multi_attach_enabled
  encrypted                 = var.ebs_encrypted
  size                      = var.ebs_volume_size_elasticsearch
  type                      = var.ebs_volume_type


  tags = {
    Name = "elasticsearch_data_volume${count.index+1}"
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}

resource "aws_ebs_volume" "prometheus_data_volume" {
  count                     = var.ebs_volume_count_prometheus
  availability_zone         = var.ebs_availability_zone
  multi_attach_enabled      = var.ebs_multi_attach_enabled
  encrypted                 = var.ebs_encrypted
  size                      = var.ebs_volume_size_prometheus
  type                      = var.ebs_volume_type


  tags = {
    Name = "prometheus_data_volume${count.index+1}"
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}