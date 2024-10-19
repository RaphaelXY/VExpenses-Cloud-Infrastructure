variable "cidr_block" {
  description = "O bloco CIDR para a VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "O bloco CIDR para a Subnet"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidade da Subnet"
  type        = string
}

variable "name" {
  description = "Nome para os recursos (VPC, Subnet)"
  type        = string
}
