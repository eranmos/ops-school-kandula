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

# "A" name record for elasticsearch server
resource "aws_route53_record" "kibana_server" {
  zone_id     = data.aws_route53_zone.my_aws_registered_domain.id
  name        = var.kibana_dns
  type        = "A"

  alias {
    name                   = aws_lb.kibana.dns_name
    zone_id                = aws_lb.kibana.zone_id
    evaluate_target_health = true
  }
}


# "A" name record for prometheus server
resource "aws_route53_record" "prometheus_server" {
  zone_id     = data.aws_route53_zone.my_aws_registered_domain.id
  name        = var.prometheus_dns
  type        = "A"

  alias {
    name                   = aws_lb.prometheus.dns_name
    zone_id                = aws_lb.prometheus.zone_id
    evaluate_target_health = true
  }
}

# "A" record on my private hosted zone kandula.int
resource "aws_route53_record" "prometheus_server_int" {
  count       = var.prometheus_instances_count
  zone_id     = data.aws_route53_zone.private_hosted_zone_domain.id
  name        = "${var.prometheus_server_name}-${count.index+1}"
  type        = "A"
  ttl         = "300"
  records     = ["${aws_instance.prometheus_server[count.index].private_ip}"]
}

resource "aws_route53_record" "consul_server_int" {
  count       = var.consul_instances_count
  zone_id     = data.aws_route53_zone.private_hosted_zone_domain.id
  name        = "${var.consul_server_name}-${count.index+1}"
  type        = "A"
  ttl         = "300"
  records     = ["${aws_instance.consul-server[count.index].private_ip}"]
}

resource "aws_route53_record" "elasticsearch_server_int" {
  count       = var.elasticsearch_instances_count
  zone_id     = data.aws_route53_zone.private_hosted_zone_domain.id
  name        = "${var.elasticsearch_server_name}-${count.index+1}"
  type        = "A"
  ttl         = "300"
  records     = ["${aws_instance.elasticsearch_server[count.index].private_ip}"]
}