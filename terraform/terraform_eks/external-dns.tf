locals {
  external_dns = merge(
  local.helm_defaults,
  {
    enabled                   = var.external_dns
    name                      = "external-dns"
    role_name                 = "${local.eks_cluster_name}-external-dns-kube"
    namespace                 = kubernetes_namespace.external_dns.id
    chart                     = "external-dns"
    repository                = "https://charts.bitnami.com/bitnami"
    service_account_name      = "external-dns-account"
    chart_version             = "4.5.5"
    version                   = "0.7.0-debian-10-r0"
  }
  )
  values_external_dns = <<VALUES
image:
  tag: "${local.external_dns["version"]}"
sources:
- service
- ingress
provider: aws
aws:
  region: "${var.aws_region}"
  zoneType: "private"
policy: sync
registry: "txt"
domainFilters:
- edp-intel-preprod.aws-int.thomsonreuters.com
txtOwnerId: "${var.asset_id}-${var.project_name}-${var.environment}"
metrics:
  enabled: false
  ## Metrics exporter pod Annotation and Labels
  ##
  # podAnnotations:
  #   prometheus.io/scrape: "true"
  #   prometheus.io/port: "7979"
  ## Prometheus Operator ServiceMonitor configuration
  ##
  serviceMonitor:
    enabled: false
    ## Namespace in which Prometheus is running
    ##
    # namespace: monitoring
serviceAccount:
  create: true
  name: "${local.external_dns["service_account_name"]}"
  annotations:
    eks.amazonaws.com/role-arn: "${local.external_dns["enabled"] ? module.iam_iam-assumable-role-with-oidc-external-dns.this_iam_role_arn : ""}"
VALUES
}

module "iam_iam-assumable-role-with-oidc-external-dns" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "3.7.0"

  aws_account_id = var.account_id
  create_role = local.external_dns["enabled"]
  number_of_role_policy_arns = 1
  role_name = "${local.external_dns["role_name"]}-policy"
  role_policy_arns = local.external_dns["enabled"] ? [aws_iam_policy.external-dns-policy[0].arn] : []
  provider_url = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.external_dns["namespace"]}:${local.external_dns["service_account_name"]}"]
  tags = local.refinitiv_tags

  depends_on = [
    kubernetes_namespace.external_dns
  ]
}

resource "aws_iam_policy" "external-dns-policy" {
  count       = local.external_dns["enabled"] ? 1 : 0
  name        = "${local.external_dns["role_name"]}-policy"
  description = "Policy for External DNS tool"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "helm_release" "external_dns" {
  count                 = local.external_dns["enabled"] ? 1 : 0

  repository            = local.external_dns["repository"]
  name                  = local.external_dns["name"]
  chart                 = local.external_dns["chart"]
  version               = local.external_dns["chart_version"]
  timeout               = local.external_dns["timeout"]
  force_update          = local.external_dns["force_update"]
  recreate_pods         = local.external_dns["recreate_pods"]
  wait                  = local.external_dns["wait"]
  atomic                = local.external_dns["atomic"]
  cleanup_on_fail       = local.external_dns["cleanup_on_fail"]
  dependency_update     = local.external_dns["dependency_update"]
  disable_crd_hooks     = local.external_dns["disable_crd_hooks"]
  disable_webhooks      = local.external_dns["disable_webhooks"]
  render_subchart_notes = local.external_dns["render_subchart_notes"]
  replace               = local.external_dns["replace"]
  reset_values          = local.external_dns["reset_values"]
  reuse_values          = local.external_dns["reuse_values"]
  skip_crds             = local.external_dns["skip_crds"]
  verify                = local.external_dns["verify"]
  values = [
    local.values_external_dns
  ]
  namespace = local.external_dns["namespace"]
}

