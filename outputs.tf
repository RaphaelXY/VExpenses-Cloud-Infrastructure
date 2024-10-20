output "private_key" {
  description = "Chave privada para acessar a instância EC2"  # Descrição da saída
  value       = tls_private_key.ec2_key.private_key_pem  # Valor da saída
  sensitive   = true  # Marca a saída como sensível
}

output "ec2_public_ip" {
  description = "Endereço IP público da instância EC2"  # Descrição da saída
  value       = module.ec2.ec2_public_ip  # Valor da saída
}
