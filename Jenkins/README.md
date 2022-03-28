<h1 align="center">Jenkins</h1>
<h6 align="center">This README will describe all Jenkins Jobs on My Project</h6>

<p align="center"><img width="250px" src="./diagrams_&_pictures/jenkins_logo.png"></p>

## Application diagram
![app_diagram](diagrams_&_pictures/ops_school-jenkins_app_diagram.png)

Jenkins Link : https://jenkins.kandula.click/

## Table of Contents

- [Jenkins-Terraform Deployment](#Jenkins-Terraform-Deployment)
- [Jenkins-Ansible Playbooks](#Jenkins-Ansible-Playbooks)
- [Jenkins-Kubernetes Deployment](#Jenkins-Kubernetes-Deployment)
- [Jenkins-Docker Images](#Jenkins-Docker-Images)
- [Jenkins-plugins](#Jenkins-plugins)

## Jenkins-Terraform Deployments

![app_diagram](diagrams_&_pictures/jenkins_terraform_jobs.png)

This view aggregat all terraform jenkins jobs

![Pipeline example](diagrams_&_pictures/jenkins_terrafrom_bastion.png)

**Job Name: terraform-bastion-server:** <br />
The job will create Bastion instance, this instance is exposed to the internet & will function as VPN server
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_bastion_server.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-bastion-server)


**Job Name: terraform-ebs_jenkins:** <br />
The job will create EBS Storage for Jenkins server to store all Jenkins Data & configs.
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_ebs_jenkins.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-ebs_jenkins/)

**Job Name: terraform-eks:** <br />
The job will create EKS Cluster.
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_eks.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-ebs_jenkins/)


**Job Name: terraform-jenkins:** <br />
The job will create Jenkins Server & Jenkins Slave ready to use.
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_jenkins.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-jenkins/)

**Job Name: terraform-postgres:** <br />
The job will create postgres DB on AWS RDS
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_postgres.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-postgres/)

**Job Name: terraform-s3-buckets:** <br />
The job will create S3 bucket for loging
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_s3_bucket.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-s3-buckets/)

**Job Name: terraform-servers:** <br />
The job will create instances for Elasticsearch, Consul and Prometheus
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_servers.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-servers/)

**Job Name: terraform-vpc:** <br />
The job will create VPC & private zone on Route53
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_vpc.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-vpc/)

## Jenkins-Ansible Playbooks

![app_diagram](diagrams_&_pictures/jenkins_ansible_jobs.png)

## Jenkins-Kubernetes Deployment

![app_diagram](diagrams_&_pictures/jenkins_k8s_jobs.png)

## Jenkins-Docker Images

![app_diagram](diagrams_&_pictures/jenkins_docker_jobs.png)

## Jenkins Plugins