<h1 align="center">Terraform S3 Buckets</h1>

<h6 align="center">Terraform which creates S3 bucket for Monitoring on AWS.</h6>

## Table of Contents

- [Prerequisites](#prerequisites)
- [Deploying Instructions](#deploying-instructions)
- [Variables References Table](#variables-references-table)

## Prerequisites
To deploy all infrastructure you will need below application to be installed on your workstation/server
+ Install [GIT](https://github.com/git-guides/install-git) on your workstation/server
+ Install [Terraform v1.1.2](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server


## Deploying Instructions

  Run the following:
   ```bash
   terraform init
   terraform apply --auto-approve
   ```

## Variables References Table

In below table you can see `variables.tf` file details:

| Variable | Type | Description |
| -------- | ---- | ----------- |
| aws_cli_profile | string | your awscli profile config |
| aws_region | string | AWS working region |
| monitoring_bucket_name | string | AWS S3 Bucket name |
| asset_owner | string  | tag - Email, preferably distribution list of the project |
| environment | string | tag - Environment i.e DEV, QA, PPE, PROD |
| asset_id | string | tag - Asset insight of the project |
| environment_name | string | tag - The name of the Environment i.e |
| owner | string |tag - Full Name of the owner |
| project_name | string| tag - The Name of the Project |