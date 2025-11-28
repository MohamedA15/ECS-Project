resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "outline-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  port                 = 6379
  security_group_ids   = [var.redis_sg_id]
}
