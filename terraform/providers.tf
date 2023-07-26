terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
provider "aws" {
  region                   = "ap-south-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "vscode"
}

# provider "kubernetes" {
#   config_path = "~/.kube/config"
#   host                   = data.aws_eks_cluster.tf_eks_cluster.endpoint
#   # token                  = data.aws_eks_cluster_auth.tf_eks_cluster_auth.token
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.tf_eks_cluster.certificate_authority.0.data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.tf_eks_cluster.name]
#     command     = "aws"
#   }
# }


