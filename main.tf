data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "learn-packer-ubuntu"
  channel     = "latest"
 }

 data "hcp_packer_image" "learn-packer-ubuntu" {
  bucket_name     = "learn-packer-ubuntu"
  channel         = "latest"
  cloud_provider  = "aws"
  region          = "us-east-2"
 }

resource "aws_instance" "app_server" {
ami           = data.hcp_packer_image.learn-packer-ubuntu.cloud_image_id
instance_type = "t2.micro"
 tags          = {
   Name = "learn_hcp_packer"
   purpose = "demo"
   ttl = "500"
   se-region = "west"
   owner = "sliu"
   terraform = "yes"
   }
  }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}

resource "aws_instance" "sandra_demo_instances" {
  ami           = data.hcp_packer_image.learn-packer-ubuntu.cloud_image_id
  instance_type = "t2.micro"
  count         = 3

  tags = {
      Name = "synopsys"
      purpose = "demo"
      ttl = "500"
      se-region = "west"
      owner = "sliu"
      terraform = "yes"
    }
}
  
