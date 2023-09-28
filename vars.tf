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
