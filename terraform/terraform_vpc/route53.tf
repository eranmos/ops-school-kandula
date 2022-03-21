
resource "aws_route53_zone" "private" {
  name          = var.private_hosted_zone_domain
  comment       = "This private zone for Kandula Project"
  force_destroy = true

  vpc {
    vpc_id = data.aws_vpc.ops-school-prod-vpc.id
  }
}