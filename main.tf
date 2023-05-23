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

 # output "packer_image" {
 #   value         = hcp_packer_image.learner-packer-ubuntu
 # }

resource "aws_instance" "app_server" {
ami           = data.hcp_packer_image.learn-packer-ubuntu.cloud_image_id
instance_type = "t2.micro"
 tags          = {
   Name = "learn_hcp_packer"
   purpose ="demo"
   terraform ="yes"
   }
  }

 resource "aws_instance" "sandra_demo_instances" {
  ami           = data.hcp_packer_image.learn-packer-ubuntu.cloud_image_id
  instance_type = "t2.micro"

  count = 2

 tags = {
    Name = "TestofaSE"
    ttl = "500"
    owner = "sliu"
    purpose = "demo"
    terraform = "yes"
  }
}