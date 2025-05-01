terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.35.0, <5.60.0, !=5.59.0"
    }
  }
  required_version = "~>1.11.4"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}

