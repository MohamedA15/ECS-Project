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

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "ecr_image" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "aws_region" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "alb_listener_arn" {
  type = string
}

variable "outline_secret_key" {
  type = string
  sensitive = true
}

variable "outline_utils_secret" {
  type = string
  sensitive = true
}

variable "database_url" {
  type = string
}

variable "redis_url" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "public_url" {
  type = string
}
