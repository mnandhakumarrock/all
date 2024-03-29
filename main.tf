terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "2.70.0"
    }
  }
}

# Provider-1 for us-east-1 (Default Provider)
provider "aws" {
  region = "us-east-1"
  profile = "default"
}

# Provider-2 for ap-south-1
provider "aws" {
  region = "ap-south-1"
  alias = "my-south"
  profile = "default"
}

# Resource Block to Create VPC in us-east-1 which uses default provider
resource "aws_vpc" "vpc-us-east-1" {
  cidr_block = "10.2.0.0/16"
  tags = {
    "Name" = "vpc-us-east-1"
  }
}

resource "aws_vpc" "vpc-ap-south-1" {
  cidr_block = "10.2.0.0/16"
  provider = aws.my-south
  tags = {
    "Name" = "vpc-ap-south-1"
  }
}

resource "aws_subnet" "pubsub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.2.0.0/16"

  tags = {
    Name = "pub-sub"
  }
}







