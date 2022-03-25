#################
#   INSTANCES   #
#################

#######   Jenkins-Slave INSTANCES   ############
resource "aws_instance" "jenkins-slave" {
  count                       = var.jenkins_slave_instances_count
  ami                         = var.jenkins_slave_ami
  instance_type               = var.jenkins_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.private-us-east-1b.id
  iam_instance_profile        = data.aws_iam_instance_profile.consul_policy.name
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  user_data                   = local.jenkins-slave-instance-userdata

  root_block_device {
    encrypted                 = var.ebs_root_encrypted
    volume_type               = var.ebs_root_volume_type
    volume_size               = var.ebs_root_volume_size_jenkins_slave
    delete_on_termination     = var.ebs_root_delete_on_termination

    tags = {
      Name                              = "${var.jenkins_slave_name}-${count.index+1}"
      Owner                             = local.eran_tags.owner
      Environment_Name                  = local.eran_tags.environment_name
      Project_Name                      = local.eran_tags.project_name
      "tr:resource-owner"               = var.asset_owner
      "tr:environment-type"             = var.environment
      "tr:application-asset-insight-id" = var.asset_id
    }
  }

  tags = {
    Name                  = "${var.jenkins_slave_name}-${count.index+1}"
    consul_server         = var.consul_server
    docker_engine         = var.docker_engine
    node_exporter         = var.node_exporter
    role                  = var.jenkins_slave_name
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }

}
