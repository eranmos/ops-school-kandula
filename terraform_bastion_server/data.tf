##########
# DATA
##########

########## Getting VPC  ##########
data "aws_vpc" "ops-school-prod-vpc" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc"]
  }
}

########## Getting Subnets  ##########
data "aws_subnet_ids" "private-subnets" {
  vpc_id =data.aws_vpc.ops-school-prod-vpc.id
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-private-*"]
  }
}

data "aws_subnet" "private-us-east-1a" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-private-us-east-1a"]
  }
}

data "aws_subnet" "public-us-east-1a" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-public-us-east-1a"]
  }
}

data "aws_subnet" "private-us-east-1b" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-private-us-east-1b"]
  }
}

data "aws_subnet" "public-us-east-1b" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-public-us-east-1b"]
  }
}

data "aws_iam_instance_profile" "consul_policy" {
    name   = "consul-join"
}