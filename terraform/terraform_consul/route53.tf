##########
# Route53
##########

# "A" name record for consul server
resource "aws_route53_record" "consul-server" {
  zone_id     = data.aws_route53_zone.my_aws_registered_domain.id
  name        = var.consul_dns
  type        = "A"

  alias {
    name                   = aws_lb.consul.dns_name
    zone_id                = aws_lb.consul.zone_id
    evaluate_target_health = true
  }
}

# "A" name record for elasticsearch server
resource "aws_route53_record" "elasticsearch_server" {
  zone_id     = data.aws_route53_zone.my_aws_registered_domain.id
  name        = var.elasticsearch_dns
  type        = "A"

  alias {
    name                   = aws_lb.elasticsearch.dns_name
    zone_id                = aws_lb.elasticsearch.zone_id
    evaluate_target_health = true
  }
}