variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "private_subnets" {
  type = list(string)
}

variable "rds_sg_id" {
  type = string
}

variable "db_name" {
  type    = string
  default = "outline"
}

variable "db_instance_class" {
  type    = string
  default = "db.t4g.micro"
}

