output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "ec2_ssh_sg_id" {
  value = module.network.ec2_ssh_sg_id
}

output "db_pasword" {
  value = module.rds.db_pasword
}

output "ec2_private_key" {
  value = module.ec2.ssh_private_key_pem
  sensitive = true
}

output "ec2_public_key" {
  value = module.ec2.ssh_public_key_pem
}