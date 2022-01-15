module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.24.0"

  cluster_name                          = local.eks_cluster_name
  cluster_version                       = "1.19" //latest kube version
  cluster_endpoint_private_access       = var.cluster_private_endpoint
  cluster_endpoint_private_access_cidrs = [data.aws_vpc.ops-school-vpc.cidr_block]
  #cluster_endpoint_public_access_cidrs  = concat(var.refinitiv_users_cidr, formatlist("%s/32", data.aws_nat_gateway.refinitiv_public.*.public_ip))
  subnets                               = concat(data.aws_subnet.public_subnet.*.id, data.aws_subnet.private_subnet.*.id)

  vpc_id = data.aws_vpc.ops-school-vpc.id
  tags   = local.common_tags
  enable_irsa = var.cluster_irsa

  workers_group_defaults = {
    subnets = data.aws_subnet.private_subnet.*.id
  }

  worker_groups_launch_template = [
    {
      name                 = "worker-group-ppe-mvp"
      instance_type        = var.instance_type
      asg_min_size         = var.asg_min_size
      asg_max_size         = var.asg_max_size
      asg_desired_capacity = var.asg_size
      ami_id               = var.ami
      root_encrypted       = var.root_encrypted
      root_volume_size     = var.root_volume_size
      additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]

      kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=`curl -s http://169.254.169.254/latest/meta-data/instance-life-cycle`"

      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "propagate_at_launch" = "true"
          "value"               = "true"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/${local.eks_cluster_name}"
          "propagate_at_launch" = "true"
          "value"               = "owned"
        }
      ]
    }
  ]

  map_roles = [
    {
      rolearn  = data.aws_iam_instance_profile.consul_policy.arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:masters"]
    }
  ]
  map_users = [
    {
      userarn  = "arn:aws:iam::113379206287:user/eran.moshayov.terraform"
      username = "eran.moshayov.terraform"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::113379206287:user/eran.moshayov"
      username = "eran.moshayov"
      groups   = ["system:masters"]
    },
  ]

}
