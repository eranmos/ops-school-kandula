#################
#   INSTANCES   #
#################

#######   Jenkins-Slave INSTANCES   ############

resource "aws_instance" "jenkins-slave" {
  ami                         = var.jenkins_slave_ami
  instance_type               = var.jenkins_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.public-us-east-1a.id
  iam_instance_profile        = data.aws_iam_instance_profile.consul_policy.name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.common_instance.id]
  user_data                   = local.jenkins-slave-instance-userdata

  root_block_device {
    encrypted                 = var.ebs_root_encrypted
    volume_type               = var.ebs_root_volume_type
    volume_size               = var.ebs_root_volume_size
      delete_on_termination     = var.ebs_root_delete_on_termination
    tags = {
      Name = "Common_Instance"
      Owner                 = local.eran_tags.owner
      Environment_Name      = local.eran_tags.environment_name
      Project_Name          = local.eran_tags.project_name
      "tr:resource-owner"   = var.asset_owner
      "tr:environment-type" = var.environment
      "tr:application-asset-insight-id" = var.asset_id
    }
  }

  tags = {
    Name = "Common_Instance"
    consul_server         = var.consul_server
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }

}

resource "aws_volume_attachment" "jenkis_master_volume_attachement" {
  volume_id   = var.ebs_jenkis_master_volume_id
  device_name = var.ebs_device_name
  instance_id = aws_instance.jenkins-slave.id
}
