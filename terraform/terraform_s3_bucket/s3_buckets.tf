########################
#    AWS S3 Buckets    #
########################
####### Creating bucket for Monitoring ###########

resource "aws_s3_bucket" "monitoring_bucket" {
  bucket        = "${var.asset_id}-${var.project_name}-${var.monitoring_bucket_name}"
  policy        = "${file("templates/policies/monitoring_bucket.json")}"
  force_destroy = false

  tags = local.common_tags
}