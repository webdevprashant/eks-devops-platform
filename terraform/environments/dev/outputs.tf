output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = "../modules.network.aws_internet_gateway.main.id"
}

output "public_subnet_1" {
  value = "../modules.network.aws_subnet.public-subnet-1.id"
}

output "public_subnet_2" {
  value = "../modules.network.aws_subnet.public-subnet-2.id"
}

output "private_subnet_1" {
  value = "../modules.network.aws_subnet.private-subnet-1.id"
}

output "private_subnet_2" {
  value = "../modules.network.aws_subnet.private-subnet-2.id"
}

output "ecr_repository_url" {
  description = "Amazon ECR Repository URL"
  value       = module.ecr.repository_url
}

output "eks_cluster_role_arn" {
  value = module.iam_eks.cluster_role_arn
}

output "eks_node_role_arn" {
  value = module.iam_eks.node_role_arn
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "oidc_issuer" {
  value = module.eks.oidc_issuer
}

output "node_group_name" {
  value = module.eks.node_group_name
}

/*
output "alb_controller_role_arn" {
  value = aws_iam_role.alb_controller.arn
}
*/

output "github_role_arn" {
  value = module.iam_github.github_role_arn
}