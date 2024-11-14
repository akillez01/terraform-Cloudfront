output "vpc_id" {
  description = "O ID do VPC"
  value       = aws_vpc.ada_vpc.id
}

output "vpc_cidr" {
  description = "O CIDR bloco do VPC"
  value       = aws_vpc.ada_vpc.cidr_block
}

output "public_subnet_ids" {
  description = "Lista de IDs das subnets públicas"
  value       = aws_subnet.ada_public[*].id
}

output "private_app_subnet_ids" {
  description = "Lista de IDs das subnets privadas de aplicações"
  value       = aws_subnet.ada_private_app[*].id
}

output "private_db_subnet_ids" {
  description = "Lista de IDs das subnets privadas de banco de dados"
  value       = aws_subnet.ada_private_db[*].id
}

output "bucket" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.ada_s3_achilles.bucket
}

output "ec2_ids" {
  description = "Lista de máquinas EC2"
  value       = aws_instance.ada_private_ec2[*].id
}

output "load_balancer_distribution_domain_name" {
  description = "Nome de domínio da distribuição do Load Balancer no CloudFront"
  value       = aws_cloudfront_distribution.load_balancer_distribution.domain_name
}

output "db_subnet_group_subnets" {
  description = "Lista de grupo de subnets para o banco de dados RDS"
  value       = aws_db_subnet_group.ada_db_subnet_group.subnet_ids
}

output "instance_ids" {
  description = "Lista de IDs das instâncias EC2"
  value       = aws_instance.ada_private_ec2[*].id
}

output "s3_distribution_domain_name" {
  description = "Nome do domínio do CloudFront de Distribuição do S3"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "rds_endpoint" {
  description = "Endpoint do RDS"
  value       = aws_rds_cluster.db_ada.endpoint
}

output "lb_dns_name" {
  description = "DNS Name do Load Balancer"
  value       = aws_lb.front_end.dns_name
}