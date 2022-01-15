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
    aws        = {
      version = ">= 3.24.1"
    }
    helm       = {
      version = ">= 2.0.1"
    }
    local      = {
      version = "~> 2.0.0"
    }
    null       = {
      version = "~> 3.0.0"
    }
    template   = {
      version = "~> 2.2.0"
    }
    archive    = {
      version = "~> 2.0.0"
    }
    kubernetes = {
      version = "~> 1.13.3"
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