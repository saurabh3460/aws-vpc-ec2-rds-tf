output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "ec2_ssh_sg_id" {
  value = module.network.ec2_ssh_sg_id
}