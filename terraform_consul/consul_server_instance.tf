#################
#   INSTANCES   #
#################

#######   Consul-Server INSTANCES   ############

resource "aws_instance" "consul-server" {
  count                       = var.consul_instances_count
  ami                         = var.ami
  instance_type               = var.consul_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.private-us-east-1a.id
  iam_instance_profile        = data.aws_iam_instance_profile.consul_policy.name
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.consul-server.id]
  user_data                   = local.consul-server-instance-userdata


  tags = {
    Name = "consul-server${count.index+1}"
    consul_server = var.consul_server
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }

}