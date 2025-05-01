variable "virginia_cidr" {
  description = "cidr virginia"
  type        = string
  sensitive   = false
}
# variable "cidr_block_public" {
#   description = "Cidr block for public_subnet"
#   type = string
# }
# variable "cidr_block_private" {
#   description = "Cidr block for private_subnet"
#   type = string
# }
variable "subnets" {
  description = "cidr for both subnets"
  type        = list(string)
}
variable "tags" {
  description = "project variable"
  type        = map(string)
}

variable "NSG_inbound_cidr" {
  description = "cidr for inbound trafict"
  type        = string
}

variable "ec2_parameters" {
  type = map(string)
}

variable "monitoring" {
  description = "this variable monitors the deployment of the conditional instance"
  type        = bool
}