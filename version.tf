terraform {
  required_providers {
    aws = {
      source = "harshicorp/aws"
      version = "5.16.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
}