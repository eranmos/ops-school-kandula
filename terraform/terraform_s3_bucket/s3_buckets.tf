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

resource "aws_s3_bucket_policy" "monitoring_bucket" {
  bucket = "${aws_s3_bucket.monitoring_bucket.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/jenkins/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/kandula_app/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/consul/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/grafana/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/prometheus/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/prometheus_ec2/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/kibana/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/elasticsearch/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/kibana/AWSLogs/113379206287/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket/AWSLogs/113379206287/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::205126-kandula-monitoring-bucket"
        }
    ]
}
POLICY
}