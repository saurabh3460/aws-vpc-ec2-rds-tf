# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

resource "aws_instance" "web" {
  # this creates drift
  # ami                         = data.aws_ami.ubuntu
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair._.key_name
  vpc_security_group_ids      = var.vpc_security_group_ids

  tags = {
    Name = "web"
  }

}

resource "tls_private_key" "_" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "_" {
  key_name   = var.key_name
  public_key = tls_private_key._.public_key_openssh
}