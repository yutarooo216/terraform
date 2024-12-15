# aws
provider "aws" {
  region = "ap-northeast-1"
}

/*
# policy json
data "aws_iam_policy_document" "allow_describe_region" {
	statement {
	effect = "Allow"
	actions = ["ec2:DescribeRegions"]
	resources = ["*"]
	}
}


# drive module 
module "describe_region_for_ec2" {
	source = "./iam_role"
	name = "describe-region-for-ec2"
	identifier = "ec2.amazonaws.com"
	policy = data.aws_iam_policy_document.allow_describe_region.json
}

# s3 test
resource "aws_s3_bucket" "private" {
	bucket = "private-pragmatic-terraform-yutarooo216"
}

resource "aws_s3_bucket_versioning" "private" {
	bucket = aws_s3_bucket.private.id
	versioning_configuration {
	 status = "Enabled"	
	 }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "private" {
	bucket = aws_s3_bucket.private.id
	rule {
	  apply_server_side_encryption_by_default {
		sse_algorithm = "AES256"
	}
 }
}

# block public access
resource "aws_s3_bucket_public_access_block" "private" {
	bucket = aws_s3_bucket.private.id

        block_public_acls = true
        block_public_policy = true
        ignore_public_acls = true
        restrict_public_buckets = true
}


# S3 log
resource "aws_s3_bucket" "alb_log" {
        bucket = "alb-log-pragmatic-terraform-yutarooo216"
}

resource "aws_s3_bucket_lifecycle_configuration" "alb_log" {
	bucket = aws_s3_bucket.alb_log.id

        rule {
		id = "log_expiration"
                status = "Enabled"

        expiration {
                days = "180"
        	}
	}
}

# alb s3 policy
resource "aws_s3_bucket_policy" "alb_log" {
	bucket = aws_s3_bucket.alb_log.id
	policy = data.aws_iam_policy_document.alb_log.json
}

# alb policy document
data "aws_iam_policy_document" "alb_log" {
	statement {
		effect = "Allow"
		actions = ["s3:PutObject"]
		resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

	principals {
		type = "AWS"
		identifiers = ["582318560864"]
	}
 }
}
*/