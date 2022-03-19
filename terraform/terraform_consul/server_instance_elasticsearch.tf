#################
#   INSTANCES   #
#################

#######   Elasticsearch INSTANCES   ############

#######   Elasticsearch 01   ############
resource "aws_instance" "elasticsearch_server" {
  count                       = var.elasticsearch_instances_count
  ami                         = var.ami
  instance_type               = var.elasticsearch_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.private-us-east-1a.id
  iam_instance_profile        = data.aws_iam_instance_profile.consul_policy.name
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.elasticsearch_server.id]
  user_data                   = local.elasticsearch_server_instance_userdata

  root_block_device {
    encrypted                 = var.ebs_root_encrypted
    volume_type               = var.ebs_root_volume_type
    volume_size               = var.ebs_root_volume_size
    delete_on_termination     = var.ebs_root_delete_on_termination

    tags = {
      Name                              = "elasticsearch_${count.index+1}"
      Owner                             = local.eran_tags.owner
      Environment_Name                  = local.eran_tags.environment_name
      Project_Name                      = local.eran_tags.project_name
      "tr:resource-owner"               = var.asset_owner
      "tr:environment-type"             = var.environment
      "tr:application-asset-insight-id" = var.asset_id
    }
  }

  tags = {
    Name                              = "elasticsearch_${count.index+1}"
    consul_server                     = false
    docker_engine                     = var.docker_engine
    node_exporter                     = var.node_exporter
    elasticsearch_master              = var.elasticsearch_master
    elasticsearch_node                = var.elasticsearch_node
    Owner                             = local.eran_tags.owner
    Environment_Name                  = local.eran_tags.environment_name
    Project_Name                      = local.eran_tags.project_name
    "tr:resource-owner"               = var.asset_owner
    "tr:environment-type"             = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}

resource "aws_ebs_volume" "elasticsearch_data_volume" {
  count                     = var.elasticsearch_instances_count
  availability_zone         = var.ebs_availability_zone
  multi_attach_enabled      = var.ebs_multi_attach_enabled
  encrypted                 = var.ebs_encrypted
  size                      = var.ebs_volume_size_elasticsearch
  type                      = var.ebs_volume_type


  tags = {
    Name = "elasticsearch_data_volume_${count.index+1}"
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}

resource "aws_volume_attachment" "elasticsearch_volume_attachement" {
  count       = var.elasticsearch_instances_count
  volume_id   = aws_ebs_volume.elasticsearch_data_volume[count.index].id
  device_name = var.ebs_device_name
  instance_id = aws_instance.elasticsearch_server[count.index].id
}
