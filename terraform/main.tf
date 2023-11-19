# AWS Configuration using Terraform

# To generate private key
resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a security group
resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  description = "Security group for allow SSH and HTTP in EC2"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
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

# To create a key pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.aws_key_name
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

# To create a private key file
resource "local_file" "private_key" {
  content  = tls_private_key.rsa-4096.private_key_pem
  filename = var.aws_key_name
}

# To create a EC2 instance
resource "aws_instance" "public_instance" {
  ami                    = var.aws_ami # ID de la imagen de Ubuntu 22.04
  instance_type          = var.aws_instance_type
  key_name               = aws_key_pair.key_pair.key_name # Cambia esto por el nombre de tu par de claves
  vpc_security_group_ids = [aws_security_group.sg_ec2.id] # Cambia esto por el ID de tu grupo de seguridad
  tags = {
    Name = "one-piece-server"
  }

  # provisioner "local-exec" {
  #   command = "ansible-playbook -i '${aws_instance.public_instance.public_ip},' --user ubuntu --private-key=/Users/LUIS/Documents/Proyectos_Personales/One-Piece-API/terraform/${var.aws_key_name} /Users/LUIS/Documents/Proyectos_Personales/One-Piece-API/utils/ansible/docker-install.yml"
  # }
}

# resource "aws_s3_bucket" "one_piece_bucket" {
#   bucket = var.aws_s3_bucket_name  # Cambia esto por el nombre que desees
# }