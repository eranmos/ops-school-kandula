locals {
  aws_ebs_csi_driver = merge(
  local.helm_defaults,
  {
    enabled                   = var.ebs_driver
    name                      = "aws-ebs-csi-driver"
    role_name                 = "${local.eks_cluster_name}-aws-ebs-csi-driver"
    namespace                 = "kube-system"
    chart                     = "aws-ebs-csi-driver"
    repository                = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver/"
    service_account_name      = "ebs-csi-controller-sa"
    chart_version             = "1.1.0"
    version                   = "v1.0.0"
    storage_class_name        = "ebs-sc"
    is_default_class          = false
    service_account_names = {
      controller       = "ebs-csi-controller-sa"
      snapshot         = "ebs-snapshot-controller"
    }
  }
  )
  values_aws_ebs_csi_driver = <<VALUES
image:
  tag: "${local.aws_ebs_csi_driver["version"]}"
enableVolumeScheduling: true
enableVolumeResizing: true
enableVolumeSnapshot: true
extraVolumeTags: 
  - "tr:resource-owner" : "${var.asset_owner}"
  - "tr:environment-type" : "${var.environment}"
  - "tr:application-asset-insight-id" : "${var.asset_id}"
extraCreateMetadata: true
k8sTagClusterId: ${local.eks_cluster_name}

serviceAccount:
  controller:
    create: true
    name: ${local.aws_ebs_csi_driver["service_account_names"]["controller"]}
    annotations:
      eks.amazonaws.com/role-arn: "${local.aws_ebs_csi_driver["enabled"] ? module.iam_iam-assumable-role-with-oidc-aws-ebs.this_iam_role_arn : ""}"
  snapshot:
    create: true
    name: ${local.aws_ebs_csi_driver["service_account_names"]["snapshot"]}
    annotations:
      eks.amazonaws.com/role-arn: "${local.aws_ebs_csi_driver["enabled"] ? module.iam_iam-assumable-role-with-oidc-aws-ebs.this_iam_role_arn : ""}"
VALUES
}

module "iam_iam-assumable-role-with-oidc-aws-ebs" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "3.7.0"

  aws_account_id = var.account_id
  create_role = local.aws_ebs_csi_driver["enabled"]
  number_of_role_policy_arns = 1
  role_name = "${local.aws_ebs_csi_driver["role_name"]}-policy"
  role_policy_arns = local.aws_ebs_csi_driver["enabled"] ? [aws_iam_policy.aws-ebs-csi-driver-policy[0].arn] : []
  provider_url = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.aws_ebs_csi_driver["namespace"]}:${local.aws_ebs_csi_driver["service_account_name"]}"]
  tags = local.common_tags
}

resource "aws_iam_policy" "aws-ebs-csi-driver-policy" {
  count       = local.aws_ebs_csi_driver["enabled"] ? 1 : 0
  name        = "${local.aws_ebs_csi_driver["role_name"]}-policy"
  description = "Policy for AWS EBS Driver"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteSnapshot",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeInstances",
        "ec2:DescribeSnapshots",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DescribeVolumesModifications",
        "ec2:DetachVolume",
        "ec2:ModifyVolume"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "helm_release" "aws_ebs_csi_driver" {
  count                 = local.aws_ebs_csi_driver["enabled"] ? 1 : 0

  repository            = local.aws_ebs_csi_driver["repository"]
  name                  = local.aws_ebs_csi_driver["name"]
  chart                 = local.aws_ebs_csi_driver["chart"]
  version               = local.aws_ebs_csi_driver["chart_version"]
  timeout               = local.aws_ebs_csi_driver["timeout"]
  force_update          = local.aws_ebs_csi_driver["force_update"]
  recreate_pods         = local.aws_ebs_csi_driver["recreate_pods"]
  wait                  = local.aws_ebs_csi_driver["wait"]
  atomic                = local.aws_ebs_csi_driver["atomic"]
  cleanup_on_fail       = local.aws_ebs_csi_driver["cleanup_on_fail"]
  dependency_update     = local.aws_ebs_csi_driver["dependency_update"]
  disable_crd_hooks     = local.aws_ebs_csi_driver["disable_crd_hooks"]
  disable_webhooks      = local.aws_ebs_csi_driver["disable_webhooks"]
  render_subchart_notes = local.aws_ebs_csi_driver["render_subchart_notes"]
  replace               = local.aws_ebs_csi_driver["replace"]
  reset_values          = local.aws_ebs_csi_driver["reset_values"]
  reuse_values          = local.aws_ebs_csi_driver["reuse_values"]
  skip_crds             = local.aws_ebs_csi_driver["skip_crds"]
  verify                = local.aws_ebs_csi_driver["verify"]
  values = [
    local.values_aws_ebs_csi_driver
  ]
  namespace = local.aws_ebs_csi_driver["namespace"]
}

resource "kubernetes_storage_class" "aws_ebs_csi_driver" {
  count  = local.aws_ebs_csi_driver["enabled"] ? 1 : 0

  metadata {
    name = local.aws_ebs_csi_driver["storage_class_name"]
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = tostring(local.aws_ebs_csi_driver["is_default_class"])
    }
  }
  storage_provisioner    = "ebs.csi.aws.com"
  volume_binding_mode    = "WaitForFirstConsumer"
}