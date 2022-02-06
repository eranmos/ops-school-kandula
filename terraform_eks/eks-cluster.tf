module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_version = var.kubernetes_version
  cluster_name    = local.eks_cluster_name
  subnets         = data.aws_subnet_ids.private-subnets.ids
  vpc_id          = data.aws_vpc.ops-school-vpc.id
  enable_irsa     = var.cluster_irsa

  worker_groups = [
    {
      name                          = "worker-group-kandula"
      instance_type                 = var.instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.all_eks_worker_mgmt.id]
    },
    {
      name                          = "worker-group-monitoring"
      instance_type                 = var.instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.all_eks_worker_mgmt.id]
    }
  ]

  tags = {
    Name                  = local.eks_cluster_name
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }

}