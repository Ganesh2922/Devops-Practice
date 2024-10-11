
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"

tags = {
    Name = "Demo"
}

  }

  resource "aws_security_group" "Secure_demo" {
  name        = "Secure demo"
  description = "allow secure connections"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SSH demo"
  }
}

resource "aws_route53_record" "demo" {
  zone_id = "Z09901269SF0OMZ8IFG8"
  name    = "trendytidbits.in"
  type    = "A"
  ttl     = 1
  records = [aws_instance.demo.public_ip]
}

output "instance_info" {
  value       = {
    public_ip = aws_instance.demo.public_ip,
  private_ip = aws_instance.demo.private_ip}
 # sensitive   = true
  #description = "description"
  #depends_on  = []
}


