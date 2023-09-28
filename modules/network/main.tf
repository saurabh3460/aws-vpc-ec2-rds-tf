terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "final-assg" {
  cidr_block = var.cidr
  tags = {
    Name = "${var.vpc_name}"
  }
} 

### Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id
  tags = {
    Name = "igw_${var.vpc_name}"
  }
}

############ Locals 

locals {
  vpc_id = aws_vpc.final-assg.id
  igw_id = aws_internet_gateway.igw.id
}

############# Public subnets

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = local.vpc_id
  cidr_block = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_${count.index}_${var.vpc_name}"
  }
}


### Public Route table
resource "aws_route_table" "public_rt" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.igw_id
  }

  tags = {
    Name = "public_rt_${var.vpc_name}"
  }
}

### Route table association with public subnets
resource "aws_route_table_association" "public_rt_associate" {
  count = length(var.public_subnets)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}


### Elastic IP
resource "aws_eip" "nat_eip" {
  depends_on = [ aws_internet_gateway.igw ]
  domain = "vpc"
  tags = {
    Name = "nat_eip_${var.vpc_name}"
  }
}

### Nat Gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public[1].id
  tags = {
    Name = "nat_gw_${var.vpc_name}"
  }
}


############# Private subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = local.vpc_id
  cidr_block = var.private_subnets[count.index]
  tags = {
    Name = "private_${count.index}_${var.vpc_name}"
  }
}

### private_rt Route table
resource "aws_route_table" "private_rt" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "nat_rt_${var.vpc_name}"
  }
}

### private_rt association with private subnets
resource "aws_route_table_association" "private_rt_associate" {
  count = length(var.private_subnets)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

############ Security groups


### ec2 
resource "aws_security_group" "ec2-ssh" {
  name = "ec2-ssh"
  description = "Security group for EC2 instances"
  vpc_id = local.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.ip_whitelists
  }

  # ingress {
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   description = "HTTP"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   description = "HTTPS"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### RDS
resource "aws_security_group" "rds" {
  name = "rds"
  description = "Security group for RDS database"
  vpc_id = local.vpc_id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [aws_security_group.ec2-ssh.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}