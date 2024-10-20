# Variável para o bloco CIDR da VPC
variable "cidr_block" {
  description = "O bloco CIDR para a VPC"       # Descrição do bloco CIDR
  type        = string                           # Define o tipo como string
}

# Variável para o bloco CIDR da Subnet
variable "subnet_cidr" {
  description = "O bloco CIDR para a Subnet"    # Descrição do bloco CIDR da Subnet
  type        = string                           # Define o tipo como string
}

# Variável para a zona de disponibilidade da Subnet
variable "availability_zone" {
  description = "Zona de disponibilidade da Subnet" # Descrição da zona de disponibilidade
  type        = string                               # Define o tipo como string
}

# Variável para o nome dos recursos (VPC, Subnet)
variable "name" {
  description = "Nome para os recursos (VPC, Subnet)" # Descrição do nome dos recursos
  type        = string                               # Define o tipo como string
}
