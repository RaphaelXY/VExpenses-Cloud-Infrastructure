variable "ami" {
  description = "AMI para a instância EC2"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
}

variable "subnet_id" {
  description = "ID da Subnet onde a instância será criada"
}

variable "key_name" {
  description = "Nome do par de chaves para a instância"
}

variable "name" {
  description = "Nome para a instância EC2"
  type        = string
}
