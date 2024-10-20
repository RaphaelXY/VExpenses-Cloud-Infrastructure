# Variável para a AMI da instância EC2
variable "ami" {
  description = "AMI para a instância EC2"  # Descrição da variável AMI
}

# Variável para o tipo da instância EC2
variable "instance_type" {
  description = "Tipo da instância EC2"     # Descrição do tipo de instância
}

# Variável para o ID da Subnet
variable "subnet_id" {
  description = "ID da Subnet onde a instância será criada"  # Descrição do ID da Subnet
}

# Variável para o nome do par de chaves
variable "key_name" {
  description = "Nome do par de chaves para a instância"  # Descrição do par de chaves
}

# Variável para o nome da instância EC2
variable "name" {
  description = "Nome para a instância EC2"  # Descrição do nome da instância
  type        = string                       # Define o tipo como string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}