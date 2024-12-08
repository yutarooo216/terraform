# aws
provider "aws" {
  region = "ap-northeast-1"
}

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

	versioning {
	 enabled = true	
	 }

	server_side_encryption_configuration {
	 rule {
	  apply_server_side_encryption_by_default {
		sse_algorithm = "AES256"
	}
  }
 }
}
