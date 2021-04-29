resource "aws_s3_bucket" "nb_elb_logs" {
  bucket = "${module.vpc_label.name}-elb-logs-s3"
  acl    = "private"
}

resource "aws_s3_bucket_policy" "nb_elb_logs_policy" {
  bucket = aws_s3_bucket.nb_elb_logs.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "nb-lb-s3-bucket-policy"
    Statement = [
      {
        Effect = "Allow"
        Principal : {
          "AWS" : [
            "arn:aws:iam::156460612806:root"
          ]
        },
        Action = "s3:PutObject"
        Resource = [
          aws_s3_bucket.nb_elb_logs.arn,
          "${aws_s3_bucket.nb_elb_logs.arn}/nb_lb_logs/AWSLogs/183824621666/*",
        ]
      },
      {
        Effect : "Allow",
        Principal : {
          "Service" : "delivery.logs.amazonaws.com"
        },
        Action : "s3:PutObject",
        Resource : [
          aws_s3_bucket.nb_elb_logs.arn,
          "${aws_s3_bucket.nb_elb_logs.arn}/nb_lb_logs/AWSLogs/183824621666/*"
        ]
        Condition : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      },
      {
        Effect : "Allow",
        Principal : {
          Service : "delivery.logs.amazonaws.com"
        },
        Action : "s3:GetBucketAcl",
        Resource : "${aws_s3_bucket.nb_elb_logs.arn}"
      }
    ]
  })
}
