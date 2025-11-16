output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}


output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}

output "ecs_sg_id" {
  value = module.security_groups.ecs_sg_id
}
