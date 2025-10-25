variable "vpc_name" {
  type    = string
  default = "ecs-mo"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.100.0/24", "10.0.101.0/24"]
}

variable "nat_eip_allocation_id" {
  type = string
  default = "eipalloc-061eccaaa23474702"
}

variable "route_table_name" {
  type = string
  default = "ecs-project-public-rt"
  
}

variable "create_nat_eip" {
  type    = bool
  default = true
}


