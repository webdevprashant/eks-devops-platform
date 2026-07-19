output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_1" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet_2" {
  value = aws_subnet.public-subnet-2.id
}

output "private_subnet_1" {
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet_2" {
  value = aws_subnet.private-subnet-2.id
}

output "ecr_repository_url" {
  description = "Amazon ECR Repository URL"
  value       = aws_ecr_repository.nodejs-app.repository_url
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "node_group_name" {
  value = aws_eks_node_group.main.node_group_name
}

output "alb_controller_role_arn" {
  value = aws_iam_role.alb_controller.arn
}

output "github_role_arn" {
  value = aws_iam_role.github_actions.arn
}