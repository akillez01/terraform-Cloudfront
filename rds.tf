resource "aws_rds_cluster" "db_ada" {
  cluster_identifier        = "db-ada"
  availability_zones        = var.availability_zones
  db_cluster_instance_class = "db.c6gd.medium"
  storage_type              = "io1"
  allocated_storage         = 400
  iops                      = 3000
  engine                    = "mysql"
  engine_version            = "8.0.39"
  master_username           = "root"
  master_password           = var.master_password
  db_subnet_group_name      = aws_db_subnet_group.ada_db_subnet_group.name
  skip_final_snapshot       = true

  tags = {
    Name        = "db-ada-mysql"
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "ada_db_subnet_group" {
  name        = "ada-db-subnet-group"
  description = "Subnet group for RDS"
  subnet_ids  = aws_subnet.ada_private_db[*].id

  tags = {
    Name        = "ada-db-subnet-group"
    Environment = var.environment
    Managed_by  = "terraform"
  }
}

