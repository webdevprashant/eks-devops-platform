variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

/*
variable "public_subnet_cidrs" {
  type = list(string)
}
*/

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

/*
variable "private_subnet_cidrs" {
  type = list(string)
}
*/

variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}