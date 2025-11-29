terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "outline-terraform-state-mo"
    key            = "state/outline/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
