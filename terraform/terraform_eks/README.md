## Create EKS cluster with Terraform
This will create an EKS cluster with terraform

## Table of Contents

- [Prerequisites](#prerequisites)
- [Deploying Instructions](#deploying-instructions)
- [Variables References Table](#variables-references-table)
- [Data Flow Table](#data-flow-table)
- [Optional](#optional)

## Prerequisites
To deploy all infrastructure you will need below application to be installed on your workstation/server
+ Install [GIT](https://github.com/git-guides/install-git) on your workstation/server
+ Install [Terraform v1.1.2](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server
+ Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) on your workstation/server
+ Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) on your workstation/server

## Deploying Instructions

Run the following:
   ```bash
   terraform init
   terraform apply --auto-approve
   ```

After the environement is up run the following to update your kubeconfig file (you can get the `cluster_name` value from the cluster_name output in terraform)
```bash
aws eks --region=us-east-1 update-kubeconfig --name <cluster_name>
```

To test the environemet run the following:
``` bash
kubectl get nodes -o wide
```

## Variables References Table

In below table you can see `variables.tf` file details:

| Variable | Type | Description |
| -------- | ----------- | ----------- |
| aws_region | string | AWS working region |
| aws_cli_profile | string | AWS cli profile name | 
| account_id | string | Account id of AWS account | 
| kubernetes_version | string | kubernetes version | 
| cluster_irsa | bool | Enable IRSA for EKS cluster | 
| instance_type | string | Kubernetes instance type for worker nodes | 
| asg_min_size | number | Minimum worker capacity in the autoscaling group | 
| asg_max_size | number | Maximum worker capacity in the autoscaling group | 
| asg_size | number | Number of nodes for Kubernetes | 
| ami | string | The AMI (ubuntu 18) that I would like to use |
| root_encrypted | bool | Whether the worker volume should be encrypted or not | 
| root_volume_size | number | Root volume size of workers instances| 
| ebs_driver | bool | Indicate installation for AWS EBS Driver | 
| aws_load_balancer_controller | bool | Indicate installation for AWS LB | 
| ingress_namespace | string | Namespace name for Ingress Controller | 
| logging_namespace | string | Namespace name for Logging Namespace | 
| monitoring_namespace | string | Namespace name for Monitoring System | 
| external_dns_namespace | string | Namespace name for External DNS | 
| external_dns | bool | Indicate installation External-DNS solution | 
| asset_owner | string  | tag - Email, preferably distribution list of the project |
| environment | string | tag - Environment i.e DEV, QA, PPE, PROD |
| asset_id | string | tag - Asset insight of the project |
| environment_name | string | tag - The name of the Environment i.e |
| owner | string |tag - Full Name of the owner |
| project_name | string| tag - The Name of the Project |


## Data Flow Table

### EKS Nodes:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| EKS_Nodes to outside | EKS_Nodes | * | * | * | * |
| Consul UI | * | * | EKS_Nodes | 443 | TCP |
| Consul API | * | * | EKS_Nodes  | 8500 | TCP |
| Consul LAN Serf | * | * | EKS_Nodes |  8301 | TCP,UDP |
| Consul Wan Serf | * | * | EKS_Nodes |  8302 | TCP,UDP |
| Consul RPC | * | * | EKS_Nodes |  8300 | TCP |
| SSH | * | * | EKS_Nodes | 22 | TCP |


### Optional
If you'd like to add more authrized users or roles to your eks cluster follow this:
1. Create an IAM role or user that is authorized to user EKS

2. From an authorized user edit [`aws-auth-cm.yaml`](aws-auth-cm.yaml) update aws-auth configmap and add the relevant users/roles and execute with kubectl
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: <Replace with ARN of your EKS nodes role>
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: arn:aws:iam::111122223333:role/eks_role 
      username: eks_role
      groups: 
        - system:masters
  mapUsers: |
    - userarn: <arn:aws:iam::111122223333:user/admin>
      username: <admin>
      groups:
        - <system:masters>
```
> **Important:** Make sure you get the nodes role arn from the currently configured configmap using `kubectl get configmap aws-auth -n kube-system  -o yaml` and replace with the above `<Replace with ARN of your EKS nodes role>`

3. If you're running with AWS cli you can verify your identity with the following:
```bash
aws sts get-caller-identity
``` 

## Read more...
- [EKS Terraform Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
- [AWS VPC Terraform Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- [Getting started with EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)
- [AWS IAM Module](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest)
- [Managing users or IAM roles for your cluster](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)
- [EKS IRSA](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)
