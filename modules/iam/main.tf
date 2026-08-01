# --- Trust policy: allows EC2 instances to assume this role ---
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# --- The IAM role EC2 instances will use ---
resource "aws_iam_role" "ec2_role" {
  name               = "${var.project_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name = "${var.project_name}-ec2-role"
  }
}

# --- Attach AWS managed policy for SSM (Session Manager access, no SSH keys needed) ---
resource "aws_iam_role_policy_attachment" "ssm_managed" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# --- Inline policy: read-only EC2 describe permissions for Ansible dynamic inventory ---
data "aws_iam_policy_document" "ec2_describe" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ec2_describe" {
  name   = "${var.project_name}-ec2-describe-policy"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2_describe.json
}
# --- Instance profile: what actually gets attached to an EC2 instance ---
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}
