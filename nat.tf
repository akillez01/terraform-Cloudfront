# Elastic IPs para os NAT Gateways, um para cada zona de disponibilidade
resource "aws_eip" "nat" {
  count  = length(var.availability_zones)
  domain = "vpc"

  tags = {
    Name        = "nat-eip-${count.index + 1}"
    Environment = var.environment
    Managed_by  = "terraform"
  }
}

# NAT Gateways associados aos Elastic IPs e sub-redes públicas
resource "aws_nat_gateway" "ada_nat_gateway" {
  count         = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.ada_public[count.index].id
  depends_on    = [aws_internet_gateway.igw_ada]

  tags = {
    Name        = "nat-gateway-${count.index + 1}"
    Environment = var.environment
    Managed_by  = "terraform"
  }
}

