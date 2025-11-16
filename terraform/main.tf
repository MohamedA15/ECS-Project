module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  create_nat_eip       = var.create_nat_eip
}


module "security_groups" {
  source = "./modules/sg"

  alb_sg_name          = "alb-security-group"
  ecs_sg_name          = "ecs-fargate-security-group"
  vpc_id               = module.vpc.vpc_id
  allow_http_from_cidr = "0.0.0.0/0"
  allow_https_from_cidr = "0.0.0.0/0"
}
