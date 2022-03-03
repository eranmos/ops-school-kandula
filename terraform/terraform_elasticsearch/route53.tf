##########
# Route53
##########

# "C" name record for elasticsearch
resource "aws_route53_record" "elasticsearch" {
  zone_id     = data.aws_route53_zone.my_aws_registered_domain.id
  name        = var.elasticsearch_dns
  type        = "CNAME"

  records = [aws_elasticsearch_domain.es.endpoint]
  ttl     = "5"
}
