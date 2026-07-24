##############################################
# Amazon EKS Cluster
##############################################

resource "aws_eks_cluster" "main" {
  name     = local.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.cluster_version
  vpc_config {
    #subnet_ids = [
    #  aws_subnet.private-subnet-1.id,
    #  aws_subnet.private-subnet-2.id
    #]
    subnet_ids = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }
  tags = {
    Name      = "eks-devops-cluster"
    ManagedBy = "Terraform"
  }
}

##############################################
# EKS Managed Node Group
##############################################

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = local.node_group_name
  node_role_arn = var.node_role_arn
  subnet_ids = var.private_subnet_ids
  capacity_type = var.capacity_type
  instance_types = var.instance_types
  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name      = "eks-node-group"
    ManagedBy = "Terraform"
  }
}