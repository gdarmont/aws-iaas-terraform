###############################################################################
# Terraform Configuration part
###############################################################################
variable "region" {
  description = "AWS region"

  // Paris
  default = "eu-west-3"
}

provider "aws" {
  region = "${var.region}"
  version = "= 1.12.0"
}

terraform {
  backend "s3" {
    bucket = "awsdemo-storage"
    key = "terraform/terraform.tfstate"
    region = "eu-west-3"
  }
}