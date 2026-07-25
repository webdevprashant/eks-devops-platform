variable "repository_name" {
  description = "ECR Repository Name"
  type        = string
}

variable "image_tag_mutability" {
  type    = string
  default = "IMMUTABLE"
}