##########
# DATA
##########

########## Getting VPC  ##########
data "aws_vpc" "ops-school-vpc" {
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc"]
  }
}

########## Getting Subnets  ##########
data "aws_subnet_ids" "private_subnets_id" {
  vpc_id =data.aws_vpc.ops-school-vpc.id
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-private-*"]
  }
}

data "aws_subnet_ids" "public_subnets_id" {
  vpc_id =data.aws_vpc.ops-school-vpc.id
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-public-*"]
  }
}

data "aws_subnet" "private_subnet" {
  count = length(data.aws_subnet_ids.private_subnets_id.ids)
  id    = tolist(data.aws_subnet_ids.private_subnets_id.ids)[count.index]
}

data "aws_subnet" "public_subnet" {
  count = length(data.aws_subnet_ids.public_subnets_id.ids)
  id    = tolist(data.aws_subnet_ids.public_subnets_id.ids)[count.index]
}

data "aws_iam_instance_profile" "consul_policy" {
  name   = "consul-join"
}