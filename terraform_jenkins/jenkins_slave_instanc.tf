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
#  user_data                   = local.jenkins-slave-instance-userdata


  tags = {
    Name = var.jenkins_slave_name
    consul_server = var.consul_server
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }

}
