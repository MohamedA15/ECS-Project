variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "alb_sg_id" { type = string }

variable "alb_name" { type = string }
variable "tg_name" { type = string }

variable "tg_port" { type = number }
variable "health_check_path" { type = string }

variable "healthy_threshold" { type = number }
variable "unhealthy_threshold" { type = number }
variable "timeout" { type = number }
variable "interval" { type = number }

variable "https_listener_port" { type = number }
variable "ssl_policy" { type = string }


variable "acm_certificate_arn" {
  type = string
}
