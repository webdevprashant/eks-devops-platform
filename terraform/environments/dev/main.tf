module "network" {
  source             = "../../modules/aws/network"
  project_name       = var.project_name
  environment        = var.environment
  region             = var.region
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  #public_subnet_cidrs = var.public_subnet_cidrs
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  enable_nat_gateway    = true
}

module "ecr" {
  source = "../../modules/aws/ecr"
  #repository_name = var.repository_name
  repository_name = "${local.name_prefix}-nodejs"
}

module "iam_eks" {
  source       = "../../modules/aws/iam/eks"
  project_name = var.project_name
  environment  = var.environment
}

module "eks" {
  source             = "../../modules/aws/eks"
  project_name       = var.project_name
  environment        = var.environment
  cluster_version    = var.cluster_version
  private_subnet_ids = module.network.private_subnet_ids
  cluster_role_arn   = module.iam_eks.cluster_role_arn
  node_role_arn      = module.iam_eks.node_role_arn
  instance_types     = var.instance_types
  desired_size       = var.desired_size
  min_size           = var.min_size
  max_size           = var.max_size
  capacity_type      = var.capacity_type
}

module "iam_github" {
  source            = "../../modules/aws/iam/github"
  project_name      = var.project_name
  environment       = var.environment
  github_repository = var.github_repository
  github_branch     = var.github_branch
  cluster_arn       = module.eks.cluster_arn
  repository_arn    = module.ecr.repository_arn
}