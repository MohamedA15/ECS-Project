variable "private_subnets" {
  type        = list(string)
  description = "Private subnets for Redis cluster"
}

variable "redis_sg_id" {
  type        = string
  description = "Security group ID to attach to Redis"
}
