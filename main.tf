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
      version = "~> 4.16"
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

  count = 2

 tags = {
    Name = "mywebappisawesome"
    purpose = "demo"
    ttl = "500"
    se-region = "west"
    owner = "sliu"
    terraform = "yes"
  }
}

check "check_budget_exceeded" {
  data "aws_budgets_budget" "example" {
    name = aws_budgets_budget.example.name
  }
 
  assert {
    condition = !data.aws_budgets_budget.example.budget_exceeded
    error_message = format("AWS budget has been exceeded! Calculated spend: '%s' and budget limit: '%s'",
                 data.aws_budgets_budget.example.calculated_spend[0].actual_spend[0].amount,
      data.aws_budgets_budget.example.budget_limit[0].amount
      )
  }
}