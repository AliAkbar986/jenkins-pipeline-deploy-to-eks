# #EKS Cluster 
# resource "aws_eks_cluster" "tf_eks_cluster" {
#   name     = "eks_cluster"
#   role_arn = aws_iam_role.tf_iam_role.arn

#   vpc_config {
#     subnet_ids = [aws_subnet.tf_public_subnet.id, aws_subnet.tf_public_subnet_2.id]

#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#   depends_on = [
#     aws_iam_role_policy_attachment.tf_AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.tf_AmazonEKSVPCResourceController,
#   ]
# }

# # IAM Role for eks
# resource "aws_iam_role" "tf_iam_role" {
#   name               = "tf_eks_cluster_role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "tf_AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.tf_iam_role.name
# }

# resource "aws_iam_role_policy_attachment" "tf_AmazonEKSVPCResourceController" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role       = aws_iam_role.tf_iam_role.name
# }

# # EKS Node Group iam role
# resource "aws_iam_role" "tf_iam_role_node" {
#   name = "eks_node_group_role"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "tf_AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.tf_iam_role_node.name

# }

# resource "aws_iam_role_policy_attachment" "tf_AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.tf_iam_role_node.name

# }

# resource "aws_iam_role_policy_attachment" "tf_AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.tf_iam_role_node.name
# }

# # EKS node Group

# resource "aws_eks_node_group" "tf_eks_node_group" {
#   cluster_name    = aws_eks_cluster.tf_eks_cluster.name
#   node_group_name = "eks_node_group"
#   node_role_arn   = aws_iam_role.tf_iam_role_node.arn
#   subnet_ids      = [aws_subnet.tf_public_subnet.id, aws_subnet.tf_public_subnet_2.id]
#   instance_types = ["t2.micro"]
#   disk_size = "10"
#   remote_access {
#     ec2_ssh_key = "tf_KeyPair"
#     source_security_group_ids = [aws_security_group.tf_sg.id]
#   }

#   scaling_config {
#     desired_size = 1
#     max_size     = 2
#     min_size     = 1
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.tf_AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.tf_AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.tf_AmazonEC2ContainerRegistryReadOnly,
#   ]
# }