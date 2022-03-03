##########
# OUTPUT
##########

output "bastion_server_public_dns" {
  value = aws_instance.bastion.public_dns
}

output "ssh_server" {
  value = "ssh -i eran_ops_school_keys.pem ubuntu@${aws_instance.bastion.public_dns}"
}
