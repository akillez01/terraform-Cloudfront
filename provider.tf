provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      environment = var.environment
      author      = "Achilles"
      project     = "terraform-ada"
    }
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}
