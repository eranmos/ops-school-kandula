####################
# Security Groups   #
####################

#######   Jenkins Server Security Group   ############

resource "aws_security_group" "jenkins" {
  vpc_id = data.aws_vpc.ops-school-prod-vpc.id
  name = local.jenkins_server.jenkins_default_name
  description = "Allow Jenkins inbound traffic"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "This is used by clients to talk to the HTTP API"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Jenkins UI from the world"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "Allow Docker Remote API port"
    from_port = 4243
    to_port = 4243
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "Allow Docker Hostport Range"
    from_port = 32768
    to_port = 60999
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "This is used by Node-Exporter for monitoring"
    from_port = 9100
    to_port = 9100
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
    description = "Allow ssh from the world"
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
    Name                              = local.jenkins_server.jenkins_default_name
    Owner                             = local.eran_tags.owner
    Environment_Name                  = local.eran_tags.environment_name
    Project_Name                      = local.eran_tags.project_name
    "tr:resource-owner"               = var.asset_owner
    "tr:environment-type"             = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}
