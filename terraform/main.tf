# VPC MODULE

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  create_nat_eip       = var.create_nat_eip
}


# SECURITY GROUPS MODULE

module "security_groups" {
  source = "./modules/sg"

  vpc_id = module.vpc.vpc_id

  alb_sg_name = var.alb_sg_name
  ecs_sg_name = var.ecs_sg_name

  http_port  = var.http_port
  https_port = var.https_port
  app_port   = var.app_port

  protocol        = var.protocol
  egress_protocol = var.egress_protocol

  http_cidr  = var.http_cidr
  https_cidr = var.https_cidr

  alb_egress_cidr = var.alb_egress_cidr
  ecs_egress_cidr = var.ecs_egress_cidr
}


# ACM MODULE

module "acm" {
  source = "./modules/acm"

  domain_name        = var.domain_name
  cloudflare_zone_id = var.cloudflare_zone_id
}


# ALB MODULE

module "alb" {
  source = "./modules/alb"

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  alb_sg_id      = module.security_groups.alb_sg_id

  alb_name = var.alb_name
  tg_name  = var.tg_name
  tg_port  = var.tg_port

  health_check_path   = var.health_check_path
  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  timeout             = var.timeout
  interval            = var.interval

  https_listener_port = var.https_listener_port
  ssl_policy          = var.ssl_policy

  acm_certificate_arn = module.acm.certificate_arn
}


# ECS MODULE

module "ecs" {
  source = "./modules/ecs"

  # Outline secrets
  outline_secret_key   = var.outline_secret_key
  outline_utils_secret = var.outline_utils_secret

  # ECS config
  cluster_name   = var.cluster_name
  service_name   = var.service_name
  container_name = var.container_name
  container_port = var.container_port
  cpu            = var.container_cpu
  memory         = var.container_memory

  # Image
  ecr_image     = var.ecr_image
  desired_count = var.ecs_desired_count
  aws_region    = var.aws_region

  # Networking
  private_subnets = module.vpc.private_subnet_ids
  ecs_sg_id       = module.security_groups.ecs_sg_id

  # Load balancer routing
  target_group_arn = module.alb.target_group_arn
  alb_listener_arn = module.alb.https_listener_arn

  # NEW REQUIRED VALUES
  database_url   = "postgresql://${var.db_username}:${var.db_password}@${module.rds.db_endpoint}:5432/outline"
  redis_url      = "redis://${module.redis.redis_endpoint}:6379"
  s3_bucket_name = module.s3.bucket_name
  public_url     = "https://${var.domain_name}"
}



module "rds" {
  source = "./modules/rds"

  db_username     = var.db_username
  db_password     = var.db_password
  private_subnets = module.vpc.private_subnet_ids
  rds_sg_id       = module.security_groups.rds_sg_id
}

module "s3" {
  source = "./modules/s3"

  bucket_name        = var.s3_bucket_name
  ecs_task_role_name = module.ecs.task_role_name
}



module "redis" {
  source = "./modules/redis"

  private_subnets = module.vpc.private_subnet_ids
  redis_sg_id     = module.security_groups.redis_sg_id
}
