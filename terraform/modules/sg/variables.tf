variable "alb_sg_name" {
  type    = string
  default = "alb-security-group"
}

variable "vpc_id" {
  type = string
}

variable "allow_http_from_cidr" {
  type        = string
  description = "CIDR block allowed to access HTTP"
  default     = "0.0.0.0/0"
}

variable "allow_https_from_cidr" {
  type        = string
  description = "CIDR block allowed to access HTTPS"
  default     = "0.0.0.0/0"
}