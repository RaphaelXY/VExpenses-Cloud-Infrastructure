# Instância EC2
resource "aws_instance" "debian_ec2" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  key_name        = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
  EOF

  tags = {
    Name = var.name
  }
}

# Outputs
output "ec2_public_ip" {
  value = aws_instance.debian_ec2.public_ip
}
