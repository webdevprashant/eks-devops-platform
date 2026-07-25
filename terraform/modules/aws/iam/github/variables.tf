variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "github_branch" {
  type    = string
  default = "main"
}

variable "cluster_arn" {
  type = string
}

variable "repository_arn" {
  type = string
}