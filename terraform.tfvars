virginia_cidr = "10.10.0.0/16"
# cidr_block_public = "10.10.0.0/24"
# cidr_block_private = "10.10.1.0/24"
subnets = ["10.10.0.0/24", "10.10.1.0/24"]
tags = {
  "Cloud" = "aws"
  "env"   = "dev"
  "owner" = "Hamilton"
  "project" = "Cerberus"
  "region" = "Virginia"
}

NSG_inbound_cidr = "0.0.0.0/0"

ec2_parameters = {
  "ami" = "ami-0e449927258d45bc4"
  "instance_type" = "t2.micro"
}

monitoring = true

