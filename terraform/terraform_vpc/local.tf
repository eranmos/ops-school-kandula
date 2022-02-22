#############
# LOCALS
#############
locals {

  eks_cluster_name = "${var.asset_id}-eks-${var.project_name}-${var.environment}"

  refinitiv_tags = {
    "tr:resource-owner"               = var.asset_owner
    "tr:environment-type"             = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }

  eran_tags = {
    "environment_name"  = var.environment_name
    "owner"             = var.owner
    "project_name"      = var.project_name

  }

  common_tags = {
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}


