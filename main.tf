data "hcp_packer_image_iteration" "ubuntu" {
  bucket_name = "learn-packer-ubuntu"
  channel     = "production"
}

data "hcp_packer_image" "baz" {
  bucket_name    = "hardened-ubuntu-16-04"
  cloud_provider = "aws"
  channel        = "production"
  region         = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "data.hcp_packer_image_ubuntu_us_east_2.cloud_image_id"
  instance_type = "t2.micro"
  tags          = {
    Name = "learn_hcp_packer"
  }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "sandra_demo_app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
    ttl = "500"
    purpose = "demo"
    terraform = "yes"
  }
}