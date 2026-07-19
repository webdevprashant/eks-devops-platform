terraform {
  backend "s3" {
    bucket  = "prashant-terraform-state69328"
    key     = "terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}