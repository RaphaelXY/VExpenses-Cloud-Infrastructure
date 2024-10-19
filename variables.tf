variable "projeto" {
  description = "Nome do projeto"
  type        = string
  default     = "VExpenses"
}

variable "candidato" {
  description = "Nome do candidato"
  type        = string
  default     = "SeuNome"
}

variable "cidr_block" {
  description = "Bloco CIDR para a VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Bloco CIDR para a Subnet"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Zona de disponibilidade da Subnet"
  default     = "sa-east-1a"
}

variable "ami" {
  description = "AMI para a instância EC2"
  default     = "ami-12345678" # Substituir pela AMI desejada
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  default     = "t2.micro"
}
