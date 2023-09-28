variable "cidr" { default = "10.0.0.0/16" }
variable "vpc_name" { default = "default_vpc" }
variable "public_subnets" { 
    type = list(string)
}

variable "private_subnets" { 
    type = list(string)
}

variable "ip_whitelists" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
}
