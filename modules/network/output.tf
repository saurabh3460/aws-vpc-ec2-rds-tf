output "public_subnet_ids" {
  value = aws_subnet.public[*].id
  description = "The IDs of the public subnets."
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
  description = "The IDs of the private subnets."
}

output "ec2_ssh_sg_id" {
  value = aws_security_group.ec2-ssh.id
  description = "The ID of the ec2-ssh security group"
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}