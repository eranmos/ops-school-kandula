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