#############
#    VPC    #
#############

module "vpc" {
  source = "github.com/eranmos/ops-school-terraform-aws-vpc"

  name                      = "${local.eran_tags.environment_name}-vpc"
  azs                       = [var.availablity_zone_a, var.availablity_zone_b]
  cidr                      = var.network_address_space
  private_subnets           = [var.private_subnet1_address_space, var.private_subnet2_address_space]
  public_subnets            = [var.public_subnet1_address_space, var.public_subnet2_address_space]
  enable_dns_hostnames      = true
  enable_nat_gateway        = true
  enable_dhcp_options       = true
  dhcp_options_domain_name  = var.private_dns_name

  tags = {
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    eks_cluster_name      = local.eks_cluster_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

}
