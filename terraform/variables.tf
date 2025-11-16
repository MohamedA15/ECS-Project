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

variable "allow_http_from_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "allow_https_from_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
