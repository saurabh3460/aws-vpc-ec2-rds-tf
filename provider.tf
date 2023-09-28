terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }


  backend "s3" {
    bucket         	   = "tf-final-assg"
    key                = "state/terraform.tfstate"
    region         	   = "ap-south-1"
    encrypt        	   = true
    dynamodb_table     = "tf-final-assg-lock"
  }
}

provider "aws" {
    region         	   = "ap-south-1"
}