# Route Table Pública
resource "aws_route_table" "ada_public_route" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_ada.id
  }

  tags = {
    Name = "${var.environment}-public-route"
  }
}

# Route Table Privada (para sub-redes privadas - app e db)
resource "aws_route_table" "private_route" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ada_nat_gateway[count.index].id
  }

  tags = {
    Name        = "private-route-${count.index + 1}"
    Environment = var.environment
    Managed_by  = "terraform"
  }
}

# Route Table Associations (Públicas)
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.ada_public[count.index].id
  route_table_id = aws_route_table.ada_public_route.id
}

# Route Table Associations (Privadas - App)
resource "aws_route_table_association" "private_app" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.ada_private_app[count.index].id
  route_table_id = aws_route_table.private_route[count.index].id
}

# Route Table Associations (Privadas - DB)
resource "aws_route_table_association" "private_db" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.ada_private_db[count.index].id
  route_table_id = aws_route_table.private_route[count.index].id
}
