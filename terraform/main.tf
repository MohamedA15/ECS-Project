module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  create_nat_eip       = var.create_nat_eip
}
