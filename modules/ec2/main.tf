# Generate private key
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair
resource "aws_key_pair" "generated_key" {
  key_name   = "terra-key-ec2"
  public_key = tls_private_key.my_key.public_key_openssh
}

# Save .pem file locally
resource "local_file" "private_key_pem" {
  content         = tls_private_key.my_key.private_key_pem
  filename        = "terra-key-ec2.pem"
  file_permission = "0400"
}

# Default VPC
resource "aws_default_vpc" "default" {}

# Security Group
resource "aws_security_group" "my_security_group" {
  name   = "automate-sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami                    = "ami-019715e0d74f695be"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  associate_public_ip_address = true


  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "terraform-ec2-strapi-task"
  }
}
