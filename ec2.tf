resource "aws_instance" "ada_private_ec2" {
  count                       = length(var.availability_zones)
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.ada_private_app[count.index].id
  security_groups             = [aws_security_group.allow_http.id]
  associate_public_ip_address = false

  tags = {
    Name        = "${var.environment}-machine-az-${element(var.availability_zones, count.index)}"
    Environment = var.environment
  }
}

