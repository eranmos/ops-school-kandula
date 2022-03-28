<h1 align="center">Terraform Jenkins</h1>

<h6 align="center">Terraform which creates Jenkins on AWS.</h6>

## Jenkins Infrastructure architecture diagram
![architecture_diagram](ops_school_mid_project-Jenkins_architecture_diagram.png)

## Application diagram
![app_diagram](ops_school-jenkins_app_diagram.png)


## Table of Contents

- [Prerequisites](#prerequisites)
- [Deploying Instructions](#deploying-instructions)
- [Variables References Table](#variables-references-table)
- [Data Flow Table](#data-flow-table)

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
| -------- | ----------- | ----------- |
| aws_region | string | AWS working region |
| aws_cli_profile | string | your awscli profile config |
| bastion_instance_name | string | The Name of the Bastion server |
| key_name | string | The key name of the Key Pair to use for the instance |
| bastion_instance_type | string | The type of the ec2, for example - t2.medium |
| ami | string | The AMI (ubuntu 18) that I would like to use for bastion |
| public_ip | bool | true= public server, false = private server|
| ebs_root_encrypted | string | if ebs should be encrypted true or false values |
| ebs_root_volume_type | string | EBS volume type like gp2... |
| ebs_root_volume_size | string | EBS volume size in G |
| ebs_root_delete_on_termination | bool | if need to delete this EBS device with terminating instance true or false values |
| asset_owner | string  | tag - Email, preferably distribution list of the project |
| environment | string | tag - Environment i.e DEV, QA, PPE, PROD |
| asset_id | string | tag - Asset insight of the project |
| environment_name | string | tag - The name of the Environment i.e |
| owner | string |tag - Full Name of the owner |
| project_name | string| tag - The Name of the Project |

## Data Flow Table


### Jenkins Master:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| Jenkins to outside | Jenkins_Master | * | * | * | * |
| Jenkins_UI | * | *  | Jenkins_Master | 443 | TCP |
| Jenkins_UI | * | * | Jenkins_Master |  80 | TCP |
| Jenkins_UI | * | * | Jenkins_Master | 8080  | TCP |
| Docker_API | * | * | Jenkins_Master | 4243 | TCP |
| Docker_Hostport | * | * | Jenkins_Master | 32768-60999 | TCP |
| Node_Exporter | * | * | Jenkins_Master  | 9100 | TCP |
| Consul | * | * | Jenkins_Master |  8301 | TCP,UDP |
| Consul | * | * | Jenkins_Master |  8302 | TCP,UDP |
| Consul | * | * | Jenkins_Master |  8300 | TCP |
| SSH | * | * | Jenkins_Master | 22 | TCP |


### Jenkins Slave:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| Jenkins to outside | Jenkins_Slave | * | * | * | * |
| Docker_API | * | * | Jenkins_Slave | 4243 | TCP |
| Docker_Hostport | * | * | Jenkins_Slave | 32768-60999 | TCP |
| Node_Exporter | * | * | Jenkins_Slave  | 9100 | TCP |
| Consul | * | * | Jenkins_Slave |  8301 | TCP,UDP |
| Consul | * | * | Jenkins_Slave |  8302 | TCP,UDP |
| Consul | * | * | Jenkins_Slave |  8300 | TCP |
| SSH | * | * | Jenkins_Slave | 22 | TCP |

