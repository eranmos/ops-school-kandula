
resource "aws_security_group" "all_eks_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = data.aws_vpc.ops-school-vpc.id
  description = "Allow SSH traffic"

  ingress {
    description = "This is used by clients to talk to the HTTPS API"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "DNS Interface Used to resolve DNS queries"
    from_port = 8600
    to_port = 8600
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP API This is used by clients to talk to the HTTP API"
    from_port = 8500
    to_port = 8500
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "LAN Serf: The Serf LAN port (TCP and UDP)"
    from_port = 8301
    to_port = 8301
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "LAN Serf: The Serf LAN port (TCP and UDP)"
    from_port = 8301
    to_port = 8301
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Wan Serf: The Serf WAN port (TCP and UDP)"
    from_port = 8302
    to_port = 8302
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Wan Serf: The Serf WAN port (TCP and UDP)"
    from_port = 8302
    to_port = 8302
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Server RPC address (TCP Only)"
    from_port = 8300
    to_port = 8300
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
