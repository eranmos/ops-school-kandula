####################
# Security Groups   #
####################

#######   Bastion Server Security Group   ############

resource "aws_security_group" "bastion-server" {
  vpc_id = data.aws_vpc.ops-school-prod-vpc.id
  name = local.common_tags.bastion_default_name
  description = "Allow bastion inbound traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    // -1 means all
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = local.common_tags.bastion_default_name
    consul_server = var.consul_server
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}