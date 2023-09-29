variable "cidr" { default = "10.0.0.0/16" }
variable "region" { default = "ap-south-1" }
variable "vpc_name" { default = "final-assg" }
variable "ip_whitelists" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
}


# ec2 modules's variables

variable "instance_type" { 
  type = string 
  default = "t3.micro"
}

variable "key_name" { 
  type = string 
  default = "final_assg_key"
}

# variable "subnet_id" { type = string }
# variable "vpc_security_group_ids" { type = list(string) }
variable "ami" { 
  type = string 
  default = "ami-0b88997c830e88c76"  
}


### RDS module's variables

variable "db_name" {type = string}
variable "instance_class" {type = string}
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

# variable "parameter_group_name" {type = string}
variable "username" {type = string}
variable "db_subnet_group_name" { type = string}