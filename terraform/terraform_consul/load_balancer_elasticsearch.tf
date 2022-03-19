#################
# Load Balancer #
#################

resource "aws_lb" "elasticsearch" {
  name                       = "elasticsearch-alb-${local.eran_tags.environment_name}"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [data.aws_subnet.public-us-east-1a.id, data.aws_subnet.public-us-east-1b.id]
  security_groups            = [aws_security_group.elasticsearch_server.id]

  access_logs {
    bucket  = var.monitoring_bucket_name
    prefix  = var.monitoring_bucket_prefix_elasticsearch
    enabled = true
  }

  tags = local.common_tags
}

#listener is configured to accept HTTP client connections.
resource "aws_lb_listener" "elasticsearch" {
  load_balancer_arn = aws_lb.elasticsearch.arn
  port              = 9200
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.elasticsearch_server.arn
  }
}

resource "aws_lb_target_group" "elasticsearch_server" {
  name      = "elasticsearch-server-group"
  port      = 9200
  protocol  = "HTTP"
  vpc_id    = data.aws_vpc.ops-school-vpc.id

  health_check {
    enabled = true
    path    = "/_cluster/health?pretty=true"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    port                = 9200
  }
  tags = {
    Name = "elasticsearch-target-group"
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}

resource "aws_lb_target_group_attachment" "elasticsearch_server" {
  count = length(aws_instance.elasticsearch_server)
  target_group_arn = aws_lb_target_group.elasticsearch_server.arn
  target_id        = aws_instance.elasticsearch_server[count.index].id
  port             = 9200
}