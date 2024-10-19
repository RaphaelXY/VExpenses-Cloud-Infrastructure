terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# Configuração do provider AWS
provider "aws" {
  region                      = "sa-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  
  endpoints {
    ec2            = "http://localhost:4566"
    iam            = "http://localhost:4566"
    route53        = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}
# Chave privada
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Par de chaves AWS
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "${var.projeto}-${var.candidato}-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# Módulo VPC
module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = var.cidr_block
  subnet_cidr         = var.subnet_cidr
  availability_zone   = var.availability_zone
  name                = "${var.projeto}-${var.candidato}"
}

# Módulo EC2
module "ec2" {
  source         = "./modules/ec2"
  ami            = var.ami
  instance_type  = var.instance_type
  subnet_id      = module.vpc.subnet_id
  key_name       = aws_key_pair.ec2_key_pair.key_name
  name           = "${var.projeto}-${var.candidato}"
}

# Associação da subnet à tabela de rotas
resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = module.vpc.subnet_id
  route_table_id = module.vpc.route_table_id
}

# Grupo de segurança
resource "aws_security_group" "main_sg" {
  name        = "${var.projeto}-${var.candidato}-sg"
  description = "Permitir SSH de qualquer lugar e todo o tráfego de saída"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["45.231.138.199/32"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.projeto}-${var.candidato}-sg"
  }
}
