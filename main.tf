data "hcp-packer-version" "hardened-source" {
  bucket_name  = "hardened-ubuntu-16-04"
  channel_name = "dev"
}

data "hcp-packer-artifact" "example" {
  bucket_name         = "hardened-ubuntu-16-04"
  version_fingerprint = data.hcp_packer_version.hardened-source.fingerprint
  platform            = "aws"
  region              = "us-east-1"
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
  count         = 2

  tags = {
      Name = "clouderademo"
      purpose = "demo"
      ttl = "500"
      se-region = "west"
      owner = "sliu"
      terraform = "yes"
    }
}
  
