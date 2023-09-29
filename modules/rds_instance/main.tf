resource "random_string" "random_rds_password" {
  length  = 32
  upper   = true
  numeric  = true
  special = false
}

resource "aws_db_subnet_group" "private_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.db_subnet_group_name
  }
}

resource "aws_db_instance" "rds" {
  depends_on = [ aws_db_subnet_group.private_subnet_group ]
  identifier             = var.db_name
  db_name                = var.db_name
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  skip_final_snapshot    = var.skip_final_snapshot
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = var.vpc_security_group_ids
  username               = var.username
  password               = "${random_string.random_rds_password.result}"
  db_subnet_group_name   = var.db_subnet_group_name           
}