#################
#   INSTANCES   #
#################

#######   Elasticsearch INSTANCES   ############
/*
#######   Elasticsearch 01   ############
resource "aws_instance" "elasticsearch_server_01" {
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
      Name                              = "elasticsearch_01"
      Owner                             = local.eran_tags.owner
      Environment_Name                  = local.eran_tags.environment_name
      Project_Name                      = local.eran_tags.project_name
      "tr:resource-owner"               = var.asset_owner
      "tr:environment-type"             = var.environment
      "tr:application-asset-insight-id" = var.asset_id
    }
  }

  tags = {
    Name                              = "elasticsearch_01"
    consul_server                     = var.consul_server
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

resource "aws_volume_attachment" "elasticsearch_01_volume_attachement" {
  volume_id   = var.ebs_elasticsearch_1_volume_id
  device_name = var.ebs_device_name
  instance_id = aws_instance.elasticsearch_server_01.id
}

#######   Elasticsearch 02   ############
resource "aws_instance" "elasticsearch_server_02" {
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
      Name                              = "elasticsearch_02"
      Owner                             = local.eran_tags.owner
      Environment_Name                  = local.eran_tags.environment_name
      Project_Name                      = local.eran_tags.project_name
      "tr:resource-owner"               = var.asset_owner
      "tr:environment-type"             = var.environment
      "tr:application-asset-insight-id" = var.asset_id
    }
  }

  tags = {
    Name                              = "elasticsearch_02"
    consul_server                     = var.consul_server
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

resource "aws_volume_attachment" "elasticsearch_02_volume_attachement" {
  volume_id   = var.ebs_elasticsearch_2_volume_id
  device_name = var.ebs_device_name
  instance_id = aws_instance.elasticsearch_server_02.id
}

#######   Elasticsearch 03   ############
resource "aws_instance" "elasticsearch_server_03" {
  ami                         = var.ami
  instance_type               = var.elasticsearch_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.private-us-east-1b.id
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
      Name                              = "elasticsearch_03"
      Owner                             = local.eran_tags.owner
      Environment_Name                  = local.eran_tags.environment_name
      Project_Name                      = local.eran_tags.project_name
      "tr:resource-owner"               = var.asset_owner
      "tr:environment-type"             = var.environment
      "tr:application-asset-insight-id" = var.asset_id
    }
  }

  tags = {
    Name                              = "elasticsearch_03"
    consul_server                     = var.consul_server
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

resource "aws_volume_attachment" "elasticsearch_03_volume_attachement" {
  volume_id   = var.ebs_elasticsearch_3_volume_id
  device_name = var.ebs_device_name
  instance_id = aws_instance.elasticsearch_server_03.id
}
*/