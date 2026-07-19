############################################
# Amazon Elastic Container Registry (ECR)
############################################

resource "aws_ecr_repository" "nodejs-app" {
  name                 = "nodejs_app"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "nodejs-app"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}