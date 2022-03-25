#################
# Load Balancer #
#################

resource "aws_lb" "prometheus" {
  name                       = "prometheus-alb-${local.eran_tags.environment_name}"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [data.aws_subnet.public-us-east-1a.id, data.aws_subnet.public-us-east-1b.id]
  security_groups            = [aws_security_group.prometheus_server.id]

  access_logs {
    bucket  = var.monitoring_bucket_name
    prefix  = var.monitoring_bucket_prefix_prometheus
    enabled = true
  }

  tags = local.common_tags
}

#listener is configured to accept HTTP client connections.
resource "aws_lb_listener" "prometheus" {
  load_balancer_arn = aws_lb.prometheus.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prometheus_server.arn
  }
}

resource "aws_lb_listener" "prometheus_80" {
  load_balancer_arn = aws_lb.prometheus.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "prometheus_server" {
  name      = "prometheus-server-group"
  port      = 9090
  protocol  = "HTTP"
  vpc_id    = data.aws_vpc.ops-school-vpc.id

  health_check {
    enabled = true
    path    = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    port                = 9090
  }
  tags = {
    Name = "prometheus-target-group"
    Owner                 = local.eran_tags.owner
    Environment_Name      = local.eran_tags.environment_name
    Project_Name          = local.eran_tags.project_name
    "tr:resource-owner"   = var.asset_owner
    "tr:environment-type" = var.environment
    "tr:application-asset-insight-id" = var.asset_id
  }
}

resource "aws_lb_target_group_attachment" "prometheus_server" {
  count = length(aws_instance.prometheus_server)
  target_group_arn = aws_lb_target_group.prometheus_server.arn
  target_id        = aws_instance.prometheus_server[count.index].id
  port             = 9090
}