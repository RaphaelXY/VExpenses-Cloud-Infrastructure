# Instância EC2
resource "aws_instance" "debian_ec2" {
  # Especifica a AMI (Amazon Machine Image) que será usada para criar a instância.
  ami             = var.ami

  # Define o tipo da instância (ex: t2.micro, t3.small, etc.), que afeta recursos de hardware como CPU e memória.
  instance_type   = var.instance_type

  # ID da subnet onde a instância será criada, garantindo que ela seja lançada em uma rede específica.
  subnet_id       = var.subnet_id

  # Nome da chave SSH que será usada para acessar a instância de forma segura.
  key_name        = var.key_name

  # user_data contém um script que será executado automaticamente ao iniciar a instância.
  # Este script é escrito em bash e realiza as seguintes ações:
  user_data = <<-EOF
    #!/bin/bash
    # Atualiza a lista de pacotes do sistema para garantir que as últimas versões estejam disponíveis.
    apt-get update -y

    # Instala o Nginx, um servidor web leve e popular.
    apt-get install -y nginx

    # Inicia o serviço do Nginx imediatamente após a instalação.
    systemctl start nginx

    # Configura o Nginx para iniciar automaticamente sempre que a instância for reiniciada.
    systemctl enable nginx
  EOF

  # Aplica tags à instância, que são úteis para identificação e organização no console da AWS.
  # Combina tags adicionais fornecidas através da variável 'var.tags' com uma tag personalizada 'Name'.
  tags = merge(var.tags, {
    Name = var.name
  })
}

# Outputs
# Exibe o endereço IP público da instância criada, facilitando o acesso e a verificação do serviço Nginx.
output "ec2_public_ip" {
  value = aws_instance.debian_ec2.public_ip
}