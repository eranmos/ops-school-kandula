##########
# Route53
##########

# "A" name record for jenkins server
resource "aws_route53_record" "jenkins-server" {
  zone_id     = data.aws_route53_zone.my_aws_registered_domain.id
  name        = var.jenkins_dns
  type        = "A"

  alias {
    name                   = aws_lb.jenkins.dns_name
    zone_id                = aws_lb.jenkins.zone_id
    evaluate_target_health = true
  }
}

# "A" record on my private hosted zone kandula.int
resource "aws_route53_record" "jenkins_server_int" {
  zone_id     = data.aws_route53_zone.private_hosted_zone_domain.id
  name        = var.jenkins_master_name
  type        = "A"
  ttl         = "300"
  records     = [aws_instance.jenkins-server.private_ip]
}

resource "aws_route53_record" "jenkins_slave_int" {
  count       = var.jenkins_slave_instances_count
  zone_id     = data.aws_route53_zone.private_hosted_zone_domain.id
  name        = "${var.jenkins_slave_name}-${count.index+1}"
  type        = "A"
  ttl         = "300"
  records     = ["${aws_instance.jenkins-slave[count.index].private_ip}"]
}
