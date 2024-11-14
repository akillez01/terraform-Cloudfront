resource "aws_vpc" "ada_vpc" {
  cidr_block = var.cidr_vpc

  tags = {
    Name        = "ada-vpc"
    Environment = var.environment
    Managed_by  = "terraform"
  }
}
resource "aws_internet_gateway" "igw_ada" {
  vpc_id = aws_vpc.ada_vpc.id

  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
    Managed_by  = "terraform"
  }
}
