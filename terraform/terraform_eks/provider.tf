#############
# Providers #
#############

provider "aws" {
  region  = var.aws_region
  profile = var.aws_cli_profile
}

terraform {
  required_version = "1.1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket  = "eran-terraform-provisioning-bucket"
    key     = "ops-school-prod/eks/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "tr-tms"
    #    dynamodb_table = "terraform-state-lock"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}