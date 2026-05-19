provider "aws" {
  region = "ap-south-1"
}

# 1. Create the Security Group (Firewall Rules)
resource "aws_security_group" "web_sg" {
  name        = "devops_web_sg"
  description = "Allow SSH and HTTP traffic"

  # Allow inbound SSH (Port 22) so GitHub Actions can connect
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTP (Port 80) so the world can see your website
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow Grafana (Dashboard)
ingress {
  from_port   = 3000
  to_port     = 3000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Allow Prometheus (Metrics Database)
ingress {
  from_port   = 9090
  to_port     = 9090
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  # Allow all outbound traffic so your server can download Docker
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Your existing server, now with the security group attached
resource "aws_instance" "my_automated_server" {
  ami                    = "ami-07a00cf47dbbc844c" # Keep your existing AMI
  instance_type          = "t3.micro"
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.web_sg.id] # Attach the firewall here

# This script runs automatically exactly once when the server boots!
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install docker.io git -y
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "Terraform-Automated-Server"
  }
}
