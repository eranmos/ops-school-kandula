<h1 align="center">Terraform Servers</h1>

<h6 align="center">Terraform which creates infrastructure for Consul Cluster, Elasticsearch, Prometheus on AWS.</h6>

## Consul Infrastructure architecture diagram
![architecture_diagram]()

## Consul Application diagram
![app_diagram]()


## Elasticsearch Infrastructure architecture diagram
![architecture_diagram]()

## Elasticsearch Application diagram
![app_diagram]()

## Prometheus Infrastructure architecture diagram
![architecture_diagram]()

## Prometheus Application diagram
![app_diagram]()


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
| -------- | ---- | ----------- |
| aws_region | string | AWS working region |
| aws_cli_profile | string | your awscli profile config |
| consul_server_name | string | The name of the consul instance |
| key_name | string |your pem key to access via ssh  |
| consul_instances_count | string | numbers of consul servers |
| consul_instance_type | string | The type of the ec2 |
| ami | string | The AMI (ubuntu 18) that I would like to use for consul |
| elasticsearch_server_name | string | The name of the es instance |
| elasticsearch_instance_type | string | The type of the ec2, for example - t2.medium |
| elasticsearch_instances_count | string | numbers of elasticsearch servers |
| elasticsearch_master | bool | True of false value,If docker engine installed |
| elasticsearch_node | bool | True of false value,If docker engine installed |
| prometheus_server_name | string | The name of the prometheus instance |
| prometheus_instances_count | string | numbers of prometheus servers |
| prometheus_instance_type | string | The type of the ec2, for example - t2.medium |
| ebs_root_encrypted | bool | if ebs should be encrypted true or false values |
| ebs_root_volume_type | string | EBS volume type like gp2... |
| ebs_root_volume_size | string | EBS volume size in G |
| ebs_root_delete_on_termination | bool | if need to delete this EBS device with terminating instance true or false values |
| monitoring_bucket_name | string | AWS S3 Bucket name |
| monitoring_bucket_prefix | string | The name of the folder that will store LB logs |
| monitoring_bucket_prefix_elasticsearch | string | The name of the folder that will store LB logs |
| monitoring_bucket_prefix_kibana | string | The name of the folder that will store LB logs |
| monitoring_bucket_prefix_prometheus | string | The name of the folder that will store LB logs |
| ebs_encrypted | string | EBS volume type like gp2... |
| ebs_multi_attach_enabled | string | Specifies whether to enable Amazon EBS Multi-Attach |
| ebs_availability_zone| string | The availability zone of the ebs volume |
| ebs_device_name | string | Name of the device to mount. |
| ebs_volume_size_elasticsearch| string | EBS volume size in G |
| ebs_volume_size_prometheus | string | EBS volume size in G |
| aws_registered_domains | string | my aws registered domains |
| consul_dns | string | consul A name record for consul DNS |
| elasticsearch_dns | string | elasticsearch A name record for ES DNS |
| kibana_dns | string | kibana A name record for ES DNS| 
| prometheus_dns | string | prometheus A name record for ES DNS | 
| private_hosted_zone_domain | string | my aws private hosted zone |
| default_s3_bucket | string | AWS s3 bucket for provisioning |
| consul_server | bool | tag - true of false value, if consul server need to be install value should be true |
| docker_engine | bool | tag - true of false value,If docker engine installed |
| node_exporter | bool | tag- true of false value,If need to install node exporter |
| asset_owner | string  | tag - Email, preferably distribution list of the project |
| environment | string | tag - Environment i.e DEV, QA, PPE, PROD |
| asset_id | string | tag - Asset insight of the project |
| environment_name | string | tag - The name of the Environment i.e |
| owner | string |tag - Full Name of the owner |
| project_name | string| tag - The Name of the Project |


## Data Flow Table

### Consul Server:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| Consul to outside | Consul | * | * | * | * |
| Consul UI | * | * | Consul | 443 | TCP |
| Consul UI | * | * | Consul | 80 | TCP |
| Consul DNS Interface  | * | * | Consul | 8600 | TCP |
| Consul API | * | * | Consul  | 8500 | TCP |
| Consul LAN Serf | * | * | Consul |  8301 | TCP,UDP |
| Consul Wan Serf | * | * | Consul |  8302 | TCP,UDP |
| Consul RPC | * | * | Consul |  8300 | TCP |
| Node_Exporter | * | * | Consul | 9100 | TCP |
| SSH | * | * | Consul | 22 | TCP |

### Elasticsearch & Kibana:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| ElasticSearch to outside | Jenkins_Slave | * | * | * | * |
| ElasticSearch_API | * | * | ElasticSearch | 9200 | TCP |
| ElasticSearch_API | * | * | ElasticSearch | 9300 | TCP |
| Kibana UI | * | * | ElasticSearch | 5601 | TCP |
| Node_Exporter | * | * | ElasticSearch  | 9100 | TCP |
| Consul | * | * | ElasticSearch |  8301 | TCP,UDP |
| Consul | * | * | ElasticSearch |  8302 | TCP,UDP |
| Consul | * | * | ElasticSearch |  8300 | TCP |
| SSH | * | * | ElasticSearch | 22 | TCP |

### Prometheus:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| Prometheus to outside | Prometheus | * | * | * | * |
| Prometheus | * | * | Prometheus | 9090 | TCP |
| Alert_Manager | * | * | Prometheus | 9093 | TCP |
| Node_Exporter | * | * | Prometheus  | 9100 | TCP |
| Consul | * | * | Prometheus |  8301 | TCP,UDP |
| Consul | * | * | Prometheus |  8302 | TCP,UDP |
| Consul | * | * | Prometheus |  8300 | TCP |
| SSH | * | * | Prometheus | 22 | TCP |