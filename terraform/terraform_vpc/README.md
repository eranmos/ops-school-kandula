<h1 align="center">Terraform VPC</h1>

<h6 align="center">Terraform which creates VPC resources on AWS.</h6>

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
| aws_cli_profile | string | AWS cli profile name |
| aws_region | string | AWS working region |
| availablity_zone_a | string | AWS availability zone X |
| availablity_zone_b | string | AWS availability zone X |
| private_dns_name | string | private dns name for dhcp options domain name |
| network_address_space | string | My VPC CIDER |
| public_subnet1_address_space | string | public ip address allocation for subnet X |
| private_subnet1_address_space | string | Private ip address allocation for subnet X |
| public_subnet2_address_space | string | public ip address allocation for subnet y |
| private_subnet2_address_space | string | Private ip address allocation for subnet y |
| private_hosted_zone_domain | string | my aws private hosted zone |
| asset_owner | string | tag - Email, preferably distribution list of the project |
| environment | string | tag - Environment i.e DEV, QA, PPE, PROD |
| asset_id | string | tag - Asset insight of the project |
| environment_name | string | tag - The name of the Environment i.e |
| owner | string | tag - Full Name of the owner |
| project_name | string | tag - The Name of the Project |
