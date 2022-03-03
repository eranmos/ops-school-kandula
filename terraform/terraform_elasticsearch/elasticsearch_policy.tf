#################
#   IAM         #
#################

resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = aws_elasticsearch_domain.es.domain_name
  access_policies = <<POLICIES
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "es:*",
      "Resource": "${aws_elasticsearch_domain.es.arn}/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "84.228.8.0/28"
        }
      }
    }
  ]
}
POLICIES
}