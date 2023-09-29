locals {
    subnets = cidrsubnets(var.cidr,10,10,10,10,10,10)
}

locals {
  public_subnets = slice(local.subnets,0,3)
  private_subnets = slice(local.subnets,3,6)
}

module "network" {
  source = "./modules/network"
  cidr = var.cidr
  public_subnets = local.public_subnets
  private_subnets = local.private_subnets
  vpc_name = var.vpc_name
  ip_whitelists = var.ip_whitelists
}


module "ec2" {
  source = "./modules/ec2_instance"
  depends_on = [ module.network ]
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.network.public_subnet_ids[1]
  vpc_security_group_ids = [module.network.ec2_ssh_sg_id]
  key_name = var.key_name
}


module "rds" {
  source = "./modules/rds_instance"
  depends_on = [ module.network ]
  db_name = var.db_name
  username = var.username
  instance_class = var.instance_class
  vpc_security_group_ids = [module.network.rds_sg_id]
  db_subnet_group_name = var.db_subnet_group_name
  subnet_ids = module.network.private_subnet_ids
}

