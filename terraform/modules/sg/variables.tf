variable "vpc_id" { type = string }

variable "alb_sg_name" { type = string }

variable "ecs_sg_name" { type = string }

variable "http_port" { type = number }

variable "https_port" { type = number }

variable "app_port" { type = number }

variable "protocol" { type = string }

variable "http_cidr" { type = string }

variable "https_cidr" { type = string }

variable "alb_egress_cidr" { type = string }

variable "ecs_egress_cidr" { type = string }

variable "egress_protocol" { type = string }
