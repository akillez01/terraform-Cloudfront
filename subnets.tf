resource "aws_subnet" "ada_public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.ada_vpc.id
  cidr_block              = cidrsubnet(var.cidr_vpc, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name        = "subnet-public-${count.index + 1}"
    Environment = var.environment
    Tier        = "Public"
    Managed_by  = "terraform"
  }
}



resource "aws_subnet" "ada_private_app" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = cidrsubnet(var.cidr_vpc, 8, count.index + 3)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "subnet-private-app-${count.index + 1}"
    Environment = var.environment
    Tier        = "Private-App"
    Managed_by  = "terraform"
  }
}

resource "aws_subnet" "ada_private_db" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = cidrsubnet(var.cidr_vpc, 8, count.index + 6)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "subnet-private-db-${count.index + 1}"
    Environment = var.environment
    Tier        = "Private-DB"
    Managed_by  = "terraform"
  }
}
