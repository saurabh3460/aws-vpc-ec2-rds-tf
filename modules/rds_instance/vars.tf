variable "db_name" {type = string}
variable "instance_class" {type = string }
variable "allocated_storage" {
    type = number
    default = 5
}
variable "engine" {
    type = string
    default = "postgres"
}
variable "engine_version" {
    type = string
    default = "15.4"
}

variable "skip_final_snapshot" {
    type = bool
    default = true
}
variable "publicly_accessible" {
    type = bool 
    default = false
}
variable "vpc_security_group_ids" {
    type = list(string) 
}

# variable "parameter_group_name" {type = string}
variable "username" {type = string}

variable "subnet_ids" {
  type = list(string)
}

variable "db_subnet_group_name" { 
    type = string
    default = "private_sg_group"
}