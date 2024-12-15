variable "name" {}
variable "policy" {}
variable "identifier" {}

# IAM role
resource "aws_iam_role" "default" {
	name = var.name
	assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# assume policy
data "aws_iam_policy_document" "assume_role" {
	statement {
	actions = ["sts:AssumeRole"]

	principals {
	type = "Service"
	identifiers = [var.identifier]
	}
 }
}

# iam policy
resource "aws_iam_policy" "default" {
	name = var.name
	policy = var.policy
}

# policy document
resource "aws_iam_role_policy_attachment" "default" {
	role = aws_iam_role.default.name
	policy_arn = aws_iam_policy.default.arn
}

# output
output "iam_role_arn" {
	value = aws_iam_role.default.arn
}

output "iam_role_name" {
	value = aws_iam_role.default.name
}
