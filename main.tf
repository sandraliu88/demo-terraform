 data "hcp_packer_image_iteration" "ubuntu" {
  bucket_name = "learn-packer-ubuntu"
  channel     = "latest"
 }

 data "hcp_packer_image" "learn-packer-ubuntu" {
  bucket_name     = "learn-packer-ubuntu"
  channel         = "latest"
  cloud_provider  = "aws"
  region          = "us-east-2"
 }

# Then replace your existing references with
# data.hcp_packer_image.learn-packer-ubuntu.cloud_image_id

resource "aws_instance" "app_server" {
ami           = "ami-097304bf0639dd83a"
instance_type = "t2.micro"
 tags          = {
   Name = "learn_hcp_packer"
   purpose ="demo"
   terraform ="yes"
   }
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
  region  = "us-east-2"
}

## resource "aws_instance" "sandra_demo_instaces" {
##  ami           = "var.ami-id"
##  instance_type = "t2.micro"

## tags = {
##    Name = "ExampleAppServerInstance"
##    ttl = "500"
##    purpose = "demo"
##    terraform = "yes"
##  }
## }