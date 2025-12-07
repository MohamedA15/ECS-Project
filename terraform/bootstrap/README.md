This module prepares the AWS backend infrastructure required for Terraform before deploying the main environment.
It creates the remote state bucket, state lock table, and an optional ECR repository used for application container images.

This module is run once only and then left in place.

📌 Purpose
 
Terraform cannot safely manage infrastructure without a remote backend.
This module provisions the backend resources so that the main Terraform configuration can:
Store state remotely in S3
Prevent concurrent runs using DynamoDB locking
Store Docker images in ECR
These resources form the foundation of all future Terraform deployments.

Resources Created
1️⃣ S3 Bucket – Terraform State
Used to store the terraform.tfstate file.
The bucket is:
Versioned
Encrypted (AES-256)
Blocked from public access
2️⃣ DynamoDB Table – State Locking
Prevents multiple Terraform runs editing the state at the same time.
3️⃣ ECR Repository (Optional)
Creates a private container registry used for storing Docker images.
You only enable this if you need a dedicated ECR for your application.

Region
This module is configured for:
eu-west-2

When to Use This Module
You run this module:
Once at the start of the project, to bootstrap the backend
Any time you want a fresh backend for a new environment.
After it has been applied you do not run it again unless intentionally recreating the backend.
Your main Terraform project will reference the resources created here.

Usage Instructions
1️⃣ Update terraform.tfvars

region            = "eu-west-2"
state_bucket_name = "outline-bootstrap-bucket-mo"
lock_table_name   = "outline-bootstrap-locks"
create_ecr        = true
ecr_repo_name     = "outline"


2️⃣ Initialise and Apply

terraform init
terraform plan
terraform apply


Backend Configuration Output
After applying, the module generates a ready-to-use backend snippet:

terraform {
  backend "s3" {
    bucket         = "outline-bootstrap-bucket-mo"
    key            = "state/outline/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "outline-bootstrap-locks"
    encrypt        = true
  }
}
Copy this into your main Terraform project (root main.tf) to enable remote state.


📁 Folder Structure
bootstrap/
  main.tf
  variables.tf
  outputs.tf
  terraform.tfvars
  README.md  
  
Summary

This module:
Creates and configures the Terraform backend
Ensures safe, remote, versioned state storage
Enables state locking
Optionally provisions an ECR repository
Is used once at the beginning of the project
After bootstrapping, the main infrastructure can be deployed using this backend reliably.


