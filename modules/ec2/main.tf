# Instância EC2
resource "aws_instance" "debian_ec2" {
  ami             = var.ami             # Especifica a AMI para a instância EC2
  instance_type   = var.instance_type   # Define o tipo da instância EC2 (ex: t2.micro)
  subnet_id       = var.subnet_id       # ID da Subnet onde a instância será criada
  key_name        = var.key_name        # Nome do par de chaves para acessar a instância

  # Script de inicialização que será executado ao iniciar a instância
  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y                   # Atualiza a lista de pacotes disponíveis
    apt-get install -y nginx             # Instala o Nginx
    systemctl start nginx                # Inicia o serviço Nginx
    systemctl enable nginx               # Habilita o Nginx para iniciar automaticamente no boot
  EOF

  # Tags para a instância, usadas para identificação
  tags = {
    Name = var.name                      # Nome da instância EC2
  }
}

# Saídas
output "ec2_public_ip" {
  value = aws_instance.debian_ec2.public_ip  # Exibe o IP público da instância EC2
}
