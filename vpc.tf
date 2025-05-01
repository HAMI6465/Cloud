resource "aws_vpc" "myvpc" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "Myvpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "Private Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "mygateway"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public crt"
  }
}

resource "aws_route_table_association" "public_crt_asosiation" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "public_instance_NSG" {
  name        = "public_NSG"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name = "public_instance_NSG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_NSG" {
  description       = "Allow inbound trafic via SSH"
  security_group_id = aws_security_group.public_instance_NSG.id
  cidr_ipv4         = var.NSG_inbound_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "inbound_NSG2" {
  description       = "Allow inbound trafic via http"
  security_group_id = aws_security_group.public_instance_NSG.id
  cidr_ipv4         = var.NSG_inbound_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "inbound_NSG23" {
  description       = "Allow inbound trafic via https"
  security_group_id = aws_security_group.public_instance_NSG.id
  cidr_ipv4         = var.NSG_inbound_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.public_instance_NSG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
