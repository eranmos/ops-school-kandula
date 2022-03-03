resource "kubernetes_namespace" "project" {

  depends_on = [
    module.eks.cluster_id,
    module.eks.config_map_aws_auth
  ]

  metadata {
    annotations = {
      name = "${var.project_name}-development"
    }
    name = "${var.project_name}-development"
  }
}

resource "kubernetes_namespace" "external_dns" {

  metadata {
    annotations = {
      name = "${var.external_dns_namespace}"
    }
    name = "${var.external_dns_namespace}"
  }
}

resource "kubernetes_namespace" "lb" {

  metadata {
    annotations = {
      name = "${var.ingress_namespace}"
    }
    name = "${var.ingress_namespace}"
  }
}

resource "kubernetes_namespace" "logging_namespace" {

  metadata {
    annotations = {
      name = "${var.logging_namespace}"
    }
    name = "${var.logging_namespace}"
  }
}


resource "kubernetes_namespace" "monitoring_namespace" {

  metadata {
    annotations = {
      name = "${var.monitoring_namespace}"
    }
    name = "${var.monitoring_namespace}"
  }
}