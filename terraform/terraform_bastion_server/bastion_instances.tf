#################
#   INSTANCES   #
#################

#######     Bastion INSTANCES   ############
resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.bastion_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.public-us-east-1a.id
  associate_public_ip_address = var.public_ip
  iam_instance_profile        = data.aws_iam_instance_profile.consul_policy.name
  vpc_security_group_ids      = [aws_security_group.bastion-server.id]
  user_data                   = local.bastion-server-instance-userdata

  root_block_device {
    encrypted                 = var.ebs_root_encrypted
    volume_type               = var.ebs_root_volume_type
    volume_size               = var.ebs_root_volume_size
    delete_on_termination     = var.ebs_root_delete_on_termination
    tags = {
      Name                              = var.bastion_instance_name
      Owner                             = local.eran_tags.owner
      Environment_Name                  = local.eran_tags.environment_name
      Project_Name                      = local.eran_tags.project_name
      "tr:resource-owner"               = var.asset_owner
      "tr:environment-type"             = var.environment
      "tr:application-asset-insight-id" = var.asset_id
    }
  }

  tags = {
    Name                              = var.bastion_instance_name
    Owner                             = local.eran_tags.owner
    Environment_Name                  = local.eran_tags.environment_name
    Project_Name                      = local.eran_tags.project_name
    "tr:resource-owner"               = var.asset_owner
    "tr:environment-type"             = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}