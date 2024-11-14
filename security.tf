resource "aws_security_group" "allow_http" {
  name        = "enable_ssh_http"
  description = "Habilitar SSH e HTTP"
  vpc_id      = aws_vpc.ada_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { # Permitir todo o tráfego de saída. Restringir em produção.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-http-sg"
  }
}

resource "aws_security_group" "database_sec" {
  name        = "database-sec"
  description = "Permits MySQL traffic"
  vpc_id      = aws_vpc.ada_vpc.id

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [for subnet in aws_subnet.ada_private_app : subnet.cidr_block] # Permitir acesso apenas da subnet da aplicação
  }

  egress { # Permitir todo o tráfego de saída. Restringir em produção.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-sg"
  }
}

resource "aws_security_group" "lb_sec" {
  name        = "lb_sec"
  description = "Allows HTTP/HTTPS traffic to the Load Balancer"
  vpc_id      = aws_vpc.ada_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restringir em produção
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sec"
  }
}
