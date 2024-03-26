data "hcp_packer_artifact" "learn-packer-ubuntu" {
  bucket_name   = "learn-packer-ubuntu"
  channel_name  = "latest"
  platform      = "aws"
  region        = "us-east-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "sandra_demo_instances" {
  ami           = data.hcp_packer_artifact.learn-packer-ubuntu.external_identifier
  instance_type = "t2.micro"
  count         = 2

  tags = {
      Name = "demoforcloudera"
      purpose = "demo"
      ttl = "500"
      se-region = "west"
      owner = "sliu"
      terraform = "yes"
    }
}
  
