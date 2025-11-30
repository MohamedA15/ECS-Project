variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "ecs-mo"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.100.0/24", "10.0.101.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "create_nat_eip" {
  type    = bool
  default = true
}

variable "alb_sg_name" {
  type    = string
  default = "alb-security-group"
}

variable "ecs_sg_name" {
  type    = string
  default = "ecs-fargate-security-group"
}

variable "http_port" {
  type    = number
  default = 80
}

variable "https_port" {
  type    = number
  default = 443
}

variable "app_port" {
  type    = number
  default = 80
}

variable "protocol" {
  type    = string
  default = "tcp"
}

variable "egress_protocol" {
  type    = string
  default = "-1"
}

variable "http_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "https_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "alb_egress_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "ecs_egress_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "alb_name" {
  type = string
}

variable "tg_name" {
  type = string
}

variable "tg_port" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "healthy_threshold" {
  type = number
}

variable "unhealthy_threshold" {
  type = number
}

variable "timeout" {
  type = number
}

variable "interval" {
  type = number
}

variable "https_listener_port" {
  type = number
}

variable "ssl_policy" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}

variable "container_cpu" {
  type = number
}

variable "container_memory" {
  type = number
}

variable "ecr_image" {
  type = string
}

variable "ecs_desired_count" {
  type = number
}

variable "aws_region" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "outline_secret_key" {
  type = string
}

variable "outline_utils_secret" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "s3_bucket_name" {
  type = string
}
