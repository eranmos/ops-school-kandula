#############
# LOCALS
#############
locals {

  jenkins_server = {
    jenkins_default_name = "jenkins"
    jenkins_home         = "/home/ubuntu/jenkins_home"
    jenkins_home_mount   = "/data/jenkins_home:/var/jenkins_home"
    docker_sock_mount    = "/var/run/docker.sock:/var/run/docker.sock"
    java_opts            = "JAVA_OPTS='-Djenkins.install.runSetupWizard=false'"
  }

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
    Owner                             = local.eran_tags.owner
    Environment_Name                  = local.eran_tags.environment_name
    Project_Name                      = local.eran_tags.project_name
    "tr:resource-owner"               = var.asset_owner
    "tr:environment-type"             = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}