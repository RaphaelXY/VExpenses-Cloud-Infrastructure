variable "projeto" {
  description = "Nome do projeto"  # Descrição da variável
  type        = string  # Tipo da variável
  default     = "VExpenses"  # Valor padrão da variável
}

variable "candidato" {
  description = "Nome do candidato"  # Descrição da variável
  type        = string  # Tipo da variável
  default     = "SeuNome"  # Valor padrão da variável
}

variable "cidr_block" {
  description = "Bloco CIDR para a VPC"  # Descrição da variável
  default     = "10.0.0.0/16"  # Valor padrão da variável
}

variable "subnet_cidr" {
  description = "Bloco CIDR para a Subnet"  # Descrição da variável
  default     = "10.0.1.0/24"  # Valor padrão da variável
}

variable "availability_zone" {
  description = "Zona de disponibilidade da Subnet"  # Descrição da variável
  default     = "sa-east-1a"  # Valor padrão da variável
}

variable "ami" {
  description = "AMI para a instância EC2"  # Descrição da variável
  default     = "ami-12345678"  # Substituir pela AMI desejada
}

variable "instance_type" {
  description = "Tipo da instância EC2"  # Descrição da variável
  default     = "t2.micro"  # Valor padrão da variável
}
