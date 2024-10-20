terraform {
  # Definindo os provedores necessários, neste caso, o AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"  # Especifica a versão do provedor AWS
    }
  }
}

# Configuração do provider AWS
provider "aws" {
  region                      = "sa-east-1"  # Região da AWS
  access_key                  = "test"  # Chave de acesso (para LocalStack)
  secret_key                  = "test"  # Chave secreta (para LocalStack)
  skip_credentials_validation = true  # Ignorar validação de credenciais
  skip_requesting_account_id  = true  # Ignorar requisição de ID da conta
  skip_metadata_api_check     = true  # Ignorar checagem da API de metadados
  
  endpoints {
    # Definindo endpoints do LocalStack para diferentes serviços AWS
    ec2            = "http://localhost:4566"
    iam            = "http://localhost:4566"
    route53        = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

# Chave privada
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"  # Algoritmo da chave
  rsa_bits  = 2048   # Tamanho da chave em bits
}

# Par de chaves AWS
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "${var.projeto}-${var.candidato}-key"  # Nome do par de chaves
  public_key = tls_private_key.ec2_key.public_key_openssh  # Chave pública gerada
}

# Módulo VPC
module "vpc" {
  source              = "./modules/vpc"  # Caminho para o módulo VPC
  cidr_block          = var.cidr_block  # Bloco CIDR para a VPC
  subnet_cidr         = var.subnet_cidr  # Bloco CIDR para a Subnet
  availability_zone   = var.availability_zone  # Zona de disponibilidade
  name                = "${var.projeto}-${var.candidato}"  # Nome dos recursos
}

# Módulo EC2
module "ec2" {
  source         = "./modules/ec2"  # Caminho para o módulo EC2
  ami            = var.ami  # AMI para a instância EC2
  instance_type  = var.instance_type  # Tipo da instância EC2
  subnet_id      = module.vpc.subnet_id  # ID da Subnet do módulo VPC
  key_name       = aws_key_pair.ec2_key_pair.key_name  # Nome do par de chaves
  name           = "${var.projeto}-${var.candidato}"  # Nome dos recursos
}

# Associação da subnet à tabela de rotas
resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = module.vpc.subnet_id  # ID da Subnet
  route_table_id = module.vpc.route_table_id  # ID da tabela de rotas
}

# Grupo de segurança
resource "aws_security_group" "main_sg" {
  name        = "${var.projeto}-${var.candidato}-sg"  # Nome do grupo de segurança
  description = "Permitir SSH de qualquer lugar e todo o tráfego de saída"  # Descrição do grupo
  vpc_id      = module.vpc.vpc_id  # ID da VPC onde o grupo será criado

  ingress {
    description = "Allow SSH from my IP"  # Descrição da regra de entrada
    from_port   = 22  # Porta de entrada
    to_port     = 22  # Porta de saída
    protocol    = "tcp"  # Protocolo (TCP)
    cidr_blocks = ["45.231.138.199/32"]  # Permitir acesso SSH somente do IP especificado
  }

  egress {
    description      = "Allow all outbound traffic"  # Descrição da regra de saída
    from_port        = 0  # Porta de entrada
    to_port          = 0  # Porta de saída
    protocol         = "-1"  # Permitir todos os protocolos
    cidr_blocks      = ["0.0.0.0/0"]  # Permitir todo tráfego de saída
    ipv6_cidr_blocks = ["::/0"]  # Permitir todo tráfego de saída IPv6
  }

  tags = {
    Name = "${var.projeto}-${var.candidato}-sg"  # Nome do grupo de segurança
  }
}
