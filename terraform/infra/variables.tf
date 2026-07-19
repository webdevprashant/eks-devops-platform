variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  default = "10.0.11.0/24"
}

variable "private_subnet_2_cidr" {
  default = "10.0.12.0/24"
}

variable "kubernetes_version" {
  description = "EKS Kubernetes Version"
  type        = string
  default     = "1.34"
}

variable "node_instance_type" {
  description = "EKS Worker Node Instance Type Spot Instances"
  type        = string
  default     = "t3.small"
}

variable "desired_size" {
  default = 2
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 3
}