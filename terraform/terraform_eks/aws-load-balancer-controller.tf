locals {
  aws_load_balancer_controller = merge(
  local.helm_defaults,
  {
    enabled                   = var.aws_load_balancer_controller
    name                      = "aws-load-balancer-controller"
    role_name                 = "${local.eks_cluster_name}-aws-load-balancer-controller"
    namespace                 = kubernetes_namespace.lb.id
    chart                     = "aws-load-balancer-controller"
    repository                = "https://aws.github.io/eks-charts"
    service_account_name      = "aws-load-balancer-controller"
    chart_version             = "1.0.5"
    version                   = "v2.0.0"
  }
  )
  values_aws_load_balancer_controller = <<VALUES
image:
  tag: "${local.aws_load_balancer_controller["version"]}"
clusterName: "${local.eks_cluster_name}"
serviceAccount:
  name: "${local.aws_load_balancer_controller["service_account_name"]}"
  annotations:
    eks.amazonaws.com/role-arn: "${local.aws_load_balancer_controller["enabled"] ? module.iam_iam-assumable-role-with-oidc-aws-lb.this_iam_role_arn : ""}"
VALUES
}

module "iam_iam-assumable-role-with-oidc-aws-lb" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "3.7.0"

  aws_account_id = var.account_id
  create_role = local.aws_load_balancer_controller["enabled"]
  number_of_role_policy_arns = 1
  role_name = "${local.aws_load_balancer_controller["role_name"]}"
  role_policy_arns = local.aws_load_balancer_controller["enabled"] ? [aws_iam_policy.aws-load-balancer-controller-policy[0].arn] : []
  provider_url = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.aws_load_balancer_controller["namespace"]}:${local.aws_load_balancer_controller["service_account_name"]}"]
  tags = local.common_tags

  depends_on = [
    kubernetes_namespace.lb
  ]
}

resource "aws_iam_policy" "aws-load-balancer-controller-policy" {
  count       = local.aws_load_balancer_controller["enabled"] ? 1 : 0
  name        = "${local.aws_load_balancer_controller["role_name"]}-policy"
  description = "Policy for AWS Load Balancer Controller"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAddresses",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeVpcs",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeInstances",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeTags",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeListenerCertificates",
                "elasticloadbalancing:DescribeSSLPolicies",
                "elasticloadbalancing:DescribeRules",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetGroupAttributes",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:DescribeTags"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cognito-idp:DescribeUserPoolClient",
                "acm:ListCertificates",
                "acm:DescribeCertificate",
                "iam:ListServerCertificates",
                "iam:GetServerCertificate",
                "waf-regional:GetWebACL",
                "waf-regional:GetWebACLForResource",
                "waf-regional:AssociateWebACL",
                "waf-regional:DisassociateWebACL",
                "wafv2:GetWebACL",
                "wafv2:GetWebACLForResource",
                "wafv2:AssociateWebACL",
                "wafv2:DisassociateWebACL",
                "shield:GetSubscriptionState",
                "shield:DescribeProtection",
                "shield:CreateProtection",
                "shield:DeleteProtection"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:RevokeSecurityGroupIngress"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateSecurityGroup"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags"
            ],
            "Resource": "arn:aws:ec2:*:*:security-group/*",
            "Condition": {
                "StringEquals": {
                    "ec2:CreateAction": "CreateSecurityGroup"
                },
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Resource": "arn:aws:ec2:*:*:security-group/*",
            "Condition": {
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:DeleteSecurityGroup"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:CreateLoadBalancer",
                "elasticloadbalancing:CreateTargetGroup"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:DeleteListener",
                "elasticloadbalancing:CreateRule",
                "elasticloadbalancing:DeleteRule"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:RemoveTags"
            ],
            "Resource": [
                "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
            ],
            "Condition": {
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:ModifyLoadBalancerAttributes",
                "elasticloadbalancing:SetIpAddressType",
                "elasticloadbalancing:SetSecurityGroups",
                "elasticloadbalancing:SetSubnets",
                "elasticloadbalancing:DeleteLoadBalancer",
                "elasticloadbalancing:ModifyTargetGroup",
                "elasticloadbalancing:ModifyTargetGroupAttributes",
                "elasticloadbalancing:DeleteTargetGroup"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:DeregisterTargets"
            ],
            "Resource": "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:SetWebAcl",
                "elasticloadbalancing:ModifyListener",
                "elasticloadbalancing:AddListenerCertificates",
                "elasticloadbalancing:RemoveListenerCertificates",
                "elasticloadbalancing:ModifyRule"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "helm_release" "aws_load_balancer_controller" {
  count                 = local.aws_load_balancer_controller["enabled"] ? 1 : 0

  repository            = local.aws_load_balancer_controller["repository"]
  name                  = local.aws_load_balancer_controller["name"]
  chart                 = local.aws_load_balancer_controller["chart"]
  version               = local.aws_load_balancer_controller["chart_version"]
  timeout               = local.aws_load_balancer_controller["timeout"]
  force_update          = local.aws_load_balancer_controller["force_update"]
  recreate_pods         = local.aws_load_balancer_controller["recreate_pods"]
  wait                  = local.aws_load_balancer_controller["wait"]
  atomic                = local.aws_load_balancer_controller["atomic"]
  cleanup_on_fail       = local.aws_load_balancer_controller["cleanup_on_fail"]
  dependency_update     = local.aws_load_balancer_controller["dependency_update"]
  disable_crd_hooks     = local.aws_load_balancer_controller["disable_crd_hooks"]
  disable_webhooks      = local.aws_load_balancer_controller["disable_webhooks"]
  render_subchart_notes = local.aws_load_balancer_controller["render_subchart_notes"]
  replace               = local.aws_load_balancer_controller["replace"]
  reset_values          = local.aws_load_balancer_controller["reset_values"]
  reuse_values          = local.aws_load_balancer_controller["reuse_values"]
  skip_crds             = local.aws_load_balancer_controller["skip_crds"]
  verify                = local.aws_load_balancer_controller["verify"]
  values = [
    local.values_aws_load_balancer_controller
  ]
  namespace = local.aws_load_balancer_controller["namespace"]
}

