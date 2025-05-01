# variable "instances" {
#   description = "names for the instances"
#   type = list(string)
#   default = [ "mysql", "apache", "nginx" ]
# }

variable "instances" {
  description = "names for the instances"
  type        = set(string)
  # default     = ["mysql", "apache", "nginx"]
  default = [ "apache" ]
}

resource "aws_instance" "public_instance" {
  # count = length(var.instances)
  for_each               = var.instances
  ami                    = var.ec2_parameters.ami
  instance_type          = var.ec2_parameters.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.public_instance_NSG.id]
  user_data              = file("data.sh")
  tags = {
  
    # Name = var.instances[count.index]
    Name = "${each.value}-${local.sufix}"
  }
}

resource "aws_instance" "monitoring_instance" {
  count                  = var.monitoring ? 2 : 0
  ami                    = var.ec2_parameters.ami
  instance_type          = var.ec2_parameters.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.public_instance_NSG.id]
  user_data              = file("data.sh")
  tags = {
    "Name" = "enable monitoring"
  }
}
#   lifecycle {
#     replace_triggered_by = [ aws_subnet.public_subnet ]
#     ignore_changes = [ ami, instance_type ]
#     prevent_destroy = false
#     create_before_destroy = false
#   }

# provisioner "local-exec" {
#   when = create
#   command = "echo hello world, instancia creada con ${aws_instance.public_instance.public_ip}> ~/data.txt"
# }

# provisioner "remote-exec" {
#   inline = [ 
#     "echo hello world > ~/saludo.txt"
#    ]
# }
# connection {
#   type = "ssh"
#   host = self.public_ip3.94.115.169
#   user = "ec2-user"
#   private_key = file("~/terraform/mykey.pem")
# }





