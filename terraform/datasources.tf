data "aws_ami" "ec2_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# data "aws_eks_cluster_auth" "tf_eks_cluster_auth" {
#   name = aws_eks_cluster.tf_eks_cluster.id
# }
# data "aws_eks_cluster" "tf_eks_cluster" {
#   name = aws_eks_cluster.tf_eks_cluster.id
# }