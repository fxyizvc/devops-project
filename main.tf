provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_automated_server" {
  ami           = "ami-07a00cf47dbbc844c" 
  instance_type = "t3.micro"
  key_name = "devops-key"

  tags = {
    Name = "Terraform-Automated-Server"
  }
}
