data "aws_vpc" "ops-school-prod-vpc" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc"]
  }
}