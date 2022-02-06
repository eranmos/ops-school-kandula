####################
# Security Groups   #
####################

#######   PostgreSQL Server Security Group   ############

resource "aws_security_group" "postgres_db" {
  name = "postgres-db"
  vpc_id = data.aws_vpc.ops-school-vpc.id
  description = "Allow postgres_db inbound traffic"

  ingress {
    description = "Allow DB accepts connections to this Port"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "postgres_db"
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}
