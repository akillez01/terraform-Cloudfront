
![AWS drawio](https://github.com/user-attachments/assets/f4514141-3fed-414b-ae22-05270252c200)

```markdown
# Projeto Final ADA - Achilles

Este repositório contém a configuração completa para a implementação de infraestrutura na AWS utilizando Terraform, com foco em deploy de uma aplicação web, banco de dados, balanceamento de carga e outros recursos essenciais.

## Sumário

1. [Visão Geral](#visão-geral)
2. [Pré-requisitos](#pré-requisitos)
3. [Configuração e Deploy](#configuração-e-deploy)
4. [Estrutura do Projeto](#estrutura-do-projeto)
5. [Código e Recursos](#código-e-recursos)
6. [Entrega e Monitoramento](#entrega-e-monitoramento)
7. [Licença](#licença)

## Visão Geral

Este projeto foi desenvolvido para configurar uma infraestrutura completa na AWS, incluindo:

- VPC com sub-redes públicas e privadas
- EC2 para a aplicação
- Load Balancer para gerenciar o tráfego HTTP
- RDS para banco de dados
- S3 para armazenamento de arquivos
- NAT Gateway para permitir acesso à internet para instâncias privadas

A configuração é feita com Terraform, garantindo a automação e fácil replicação da infraestrutura.

## Pré-requisitos

Antes de começar, verifique se você tem os seguintes pré-requisitos:

- **AWS Account**: Certifique-se de ter uma conta AWS configurada e as credenciais apropriadas.
- **Terraform**: Instale o Terraform em sua máquina. Você pode seguir a [documentação oficial](https://www.terraform.io/downloads.html).
- **AWS CLI**: Instale e configure a AWS CLI em sua máquina, se ainda não tiver.

Para configurar suas credenciais AWS:

```bash
aws configure
```

## Configuração e Deploy

### Passo 1: Clone este repositório

Clone o repositório para sua máquina local:

```bash
git clone https://github.com/akillez01/projeto-final-ada-achilles.git
cd projeto-final-ada-achilles
```

### Passo 2: Inicialize o Terraform

Dentro do diretório do projeto, execute o comando abaixo para inicializar o Terraform:

```bash
terraform init
```

### Passo 3: Verifique o plano de execução

Verifique o plano de execução do Terraform para garantir que a infraestrutura será criada conforme esperado:

```bash
terraform plan
```

### Passo 4: Aplique a configuração

Execute o comando a seguir para criar e provisionar todos os recursos na AWS:

```bash
terraform apply
```

O Terraform pedirá confirmação para aplicar as mudanças. Digite `yes` para continuar.

### Passo 5: Acesso à aplicação

Após o deploy, o Terraform criará um Load Balancer na AWS para gerenciar o tráfego para suas instâncias EC2. Você pode acessar sua aplicação usando o DNS do Load Balancer, que será exibido ao final da execução do Terraform.

### Passo 6: Limpeza

Para destruir a infraestrutura criada e evitar custos adicionais, você pode rodar o seguinte comando:

```bash
terraform destroy
```

## Estrutura do Projeto

Este repositório contém os seguintes arquivos principais:

- **`main.tf`**: Arquivo principal com a configuração da infraestrutura.
- **`variables.tf`**: Definição de variáveis que são utilizadas no projeto.
- **`output.tf`**: Define os outputs, como endereços IP e DNS para acesso à aplicação.
- **`lb.tf`**: Configuração do Load Balancer e Target Groups.
- **`rds.tf`**: Configuração do banco de dados RDS.
- **`nat.tf`**: Configuração do NAT Gateway.
- **`security.tf`**: Definições de grupos de segurança.
- **`s3.tf`**: Configuração do bucket S3 para armazenamento.
- **`routes.tf`**: Configuração das rotas e associações de tabela de rotas.
- **`outputs.tf`**: Outputs para facilitar o acesso aos recursos criados, como IPs e DNS.

## Código e Recursos

Aqui estão alguns trechos de código para configurar os recursos principais:

### Exemplo de configuração do Load Balancer:

```hcl
resource "aws_lb" "front_end" {
  name               = "front-end"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.front_end_sec.id]
  subnets            = aws_subnet.ada_public_subnet[*].id

  enable_deletion_protection = false

  tags = {
    Name        = "front_end"
    Environment = var.environment
  }
}
```

### Exemplo de configuração do RDS:

```hcl
resource "aws_rds_cluster" "db_ada" {
  cluster_identifier = "db-ada"
  engine            = "aurora"
  master_username   = "admin"
  master_password   = var.db_password
  database_name     = "mydb"
  vpc_security_group_ids = [aws_security_group.database_sec.id]
  skip_final_snapshot = true
}
```

### Exemplo de configuração do S3:

```hcl
resource "aws_s3_bucket" "ada_s3_achilles" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name        = "ada-bucket-app"
    Environment = var.environment
  }
}
```

## Entrega e Monitoramento

A entrega do projeto será considerada concluída quando todos os recursos forem criados corretamente na AWS e o serviço estiver acessível através do Load Balancer. Para monitoramento, você pode usar o CloudWatch para verificar os logs de aplicação e infraestrutura.

1. **Acessar logs do Load Balancer**: Acesse o AWS CloudWatch e consulte os logs gerados pelo Load Balancer.
2. **Monitorar a saúde das instâncias**: Verifique o Target Group no painel do Load Balancer para garantir que as instâncias EC2 estão saudáveis.

## Licença

Este projeto é licenciado sob a [MIT License](LICENSE).
```

Esse `README.md` cobre os principais aspectos do seu projeto, como configuração, implementação e entrega na AWS. Ele também contém os principais trechos de código que você utilizou em sua configuração.