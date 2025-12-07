output "bucket_name" {
  value = var.state_bucket_name
}

output "lock_table_name" {
  value = var.lock_table_name
}

output "ecr_repo_name" {
  value = var.ecr_repo_name
}


output "real_backend_config" {
  value = <<EOF
terraform {
  backend "s3" {
    bucket         = "${var.state_bucket_name}"
    key            = "state/outline/terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "${var.lock_table_name}"
    encrypt        = true
  }
}
EOF
}
