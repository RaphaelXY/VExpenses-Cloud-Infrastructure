# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.cidr_block           # Bloco CIDR da VPC
  enable_dns_support   = true                     # Habilita suporte a DNS na VPC
  enable_dns_hostnames = true                     # Habilita nomes de host DNS na VPC

  # Tags para a VPC
  tags = {
    Name = var.name                              # Nome da VPC
  }
}

# Subnet
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id        # ID da VPC onde a Subnet será criada
  cidr_block        = var.subnet_cidr            # Bloco CIDR da Subnet
  availability_zone = var.availability_zone      # Zona de disponibilidade da Subnet

  # Tags para a Subnet
  tags = {
    Name = var.name                              # Nome da Subnet
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id                  # ID da VPC associada ao Internet Gateway

  # Tags para o Internet Gateway
  tags = {
    Name = var.name                              # Nome do Internet Gateway
  }
}

# Route Table
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id                  # ID da VPC associada à tabela de rotas

  route {
    cidr_block = "0.0.0.0/0"                     # Rota para todo o tráfego
    gateway_id = aws_internet_gateway.main_igw.id # Gateway associado à rota
  }

  # Tags para a tabela de rotas
  tags = {
    Name = var.name                              # Nome da tabela de rotas
  }
}

# Saídas
output "vpc_id" {
  value = aws_vpc.main_vpc.id                    # Exibe o ID da VPC
}

output "subnet_id" {
  value = aws_subnet.main_subnet.id              # Exibe o ID da Subnet
}

output "route_table_id" {
  value = aws_route_table.main_route_table.id    # Exibe o ID da tabela de rotas
}
