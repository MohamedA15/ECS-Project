# Terraform Backend Bootstrap Module 

##  Purpose
Creates AWS backend infrastructure for Terraform state management. Run this **once only** before deploying main infrastructure.

##  Resources Created
- **S3 Bucket** – Versioned, encrypted state storage
- **DynamoDB Table** – State locking to prevent concurrent operations  
- **ECR Repository** – Private container registry

##  Region
Configured for **eu-west-2**

##  Quick Start

### 1. Configure `terraform.tfvars`
region = "eu-west-2"
state_bucket_name = "outline-bootstrap-bucket-mo"
lock_table_name = "outline-bootstrap-locks"
create_ecr = true
ecr_repo_name = "outline"


##  Module Structure
Bootstrap (Local State)
    │
    ├─► S3 Bucket (State Storage)
    │   ├─► Versioning Enabled
    │   ├─► Encryption Enabled
    │   ├─► Public Access Blocked
    │   └─► Lifecycle Rules
    │
    ├─► DynamoDB Table (State Locking)
    │   ├─► Pay-per-request Billing
    │   ├─► LockID as primary key
    │   └─► Tags for management
    │
    └─► ECR Repository (Container Images)
        ├─► Private registry
        ├─► Image scanning on push
        └─► Mutable image tags

Main Infrastructure (Remote State)
    │
    └─► Uses Bootstrap Resources ─► ECS, VPC, etc.

```

```bash
terraform plan
terraform apply
```


##  Next Steps
AFTER BOOTSTRAP, GO TO YOUR MAIN TERRAFORM FOLDER AND:

Open provider.tf
Add the backend config block (like above)
Run terraform init to migrate to remote state
It will ask to copy existing state to S3 - say YES
Then deploy main infrastructure: terraform apply

## ⚠️ Important
- Bucket names must be globally unique
- Never run this module again after initial setup
- Destroying this will delete all Terraform state