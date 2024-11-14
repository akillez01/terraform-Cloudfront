variable "cidr_vpc" {
  description = "CIDR block para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade (AZs) da AWS"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "environment" {
  description = "Ambiente da aplicação (ex: produção, desenvolvimento)"
  type        = string
  default     = "production"
}

variable "bucket_name" {
  description = "Nome do bucket S3 para a aplicação"
  type        = string
  default     = "ada-s3-achilles"
}

variable "subnet_public_cidr_blocks" {
  description = "CIDR blocks para as sub-redes públicas"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "subnet_private_cidr_blocks" {
  description = "CIDR blocks para as sub-redes privadas"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
}

variable "instance_type" {
  description = "Tipo de instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "master_password" {
  description = "Senha para o banco de dados RDS"
  type        = string
  sensitive   = true
  default     = "admin1234"
}
