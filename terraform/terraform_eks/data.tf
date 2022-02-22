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
data "aws_subnet_ids" "private-subnets" {
  vpc_id =data.aws_vpc.ops-school-vpc.id
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-private-*"]
  }
}

data "aws_subnet_ids" "public-subnets" {
  vpc_id =data.aws_vpc.ops-school-vpc.id
  filter {
    name   = "tag:Name"
    values = ["ops-school-vpc-public-*"]
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


########## Getting AMI's from publifc images  ##########
data "aws_ami" "ubuntu-18" {
  most_recent = true
  owners      = [var.ubuntu_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_iam_instance_profile" "consul_policy" {
  name   = "consul-join"
}

########## EKS Data  ##########
data "aws_vpc" "ops_school_eks_cluster_name" {
  filter {
    name   = "tag:eks_cluster_name"
    values = ["${var.asset_id}-eks-${var.project_name}-${var.environment}"]
  }
}

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

