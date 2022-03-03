
resource "aws_security_group" "all_eks_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = data.aws_vpc.ops-school-vpc.id
  description = "Allow SSH traffic"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/21",
    ]
  }

  tags = {
    Name                              = local.eks_cluster_name
    Owner                             = local.eran_tags.owner
    Environment_Name                  = local.eran_tags.environment_name
    Project_Name                      = local.eran_tags.project_name
    "tr:resource-owner"               = var.asset_owner
    "tr:environment-type"             = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }

}