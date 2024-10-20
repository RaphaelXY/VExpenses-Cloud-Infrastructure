# Instância EC2
resource "aws_instance" "debian_ec2" {
  ami             = var.ami             # Especifica a AMI para a instância EC2
  instance_type   = var.instance_type   # Define o tipo da instância EC2 (ex: t2.micro)
  subnet_id       = var.subnet_id       # ID da Subnet onde a instância será criada
  key_name        = var.key_name        # Nome do par de chaves para acessar a instância

   root_block_device {
    encrypted = true
  }

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

resource "aws_instance" "debian_ec2" {
  # ... (outras configurações existentes)

  tags = var.tags

  # Adicione isso para habilitar o CloudWatch Logs
  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx awslogs
    systemctl start nginx
    systemctl enable nginx
    
    # Configurar o CloudWatch Logs
    cat > /etc/awslogs/awslogs.conf << EOL
    [general]
    state_file = /var/lib/awslogs/agent-state
    
    [/var/log/syslog]
    file = /var/log/syslog
    log_group_name = ${aws_cloudwatch_log_group.ec2_logs.name}
    log_stream_name = {instance_id}/syslog
    datetime_format = %b %d %H:%M:%S
    EOL
    
    systemctl start awslogsd
    systemctl enable awslogsd
  EOF
}
output "ec2_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.debian_ec2.arn
}