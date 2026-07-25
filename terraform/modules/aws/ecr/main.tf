############################################
# Amazon Elastic Container Registry (ECR)
############################################

resource "aws_ecr_repository" "repo" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "nodejs-app"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.repo.name
  policy     = file("${path.module}/lifecycle-policy.json")
}