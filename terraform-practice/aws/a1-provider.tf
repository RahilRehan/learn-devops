# Terraform block
terraform {
    required_version = "~> 1.1"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

# Provider block
provider "aws" {
    region = "ap-south-1"
}