resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Security group for the Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.alb_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.http_cidr
  from_port         = var.http_port
  to_port           = var.http_port
  ip_protocol       = var.protocol
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.https_cidr
  from_port         = var.https_port
  to_port           = var.https_port
  ip_protocol       = var.protocol
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.alb_egress_cidr
  ip_protocol       = var.egress_protocol
}

# ECS SG
resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_sg_name
  description = "Security group for ECS Fargate tasks"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.ecs_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_ingress_from_alb" {
  security_group_id            = aws_security_group.ecs_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = var.app_port
  to_port                      = var.app_port
  ip_protocol                  = var.protocol
}

resource "aws_vpc_security_group_egress_rule" "ecs_egress_all" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = var.ecs_egress_cidr
  ip_protocol       = var.egress_protocol
}

# RDS SG
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for RDS Postgres"
  vpc_id      = var.vpc_id

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_ingress_from_ecs" {
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.ecs_sg.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

# Redis SG
resource "aws_security_group" "redis_sg" {
  name        = "redis-sg"
  description = "Security group for Redis"
  vpc_id      = var.vpc_id

  tags = {
    Name = "redis-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "redis_ingress_from_ecs" {
  security_group_id            = aws_security_group.redis_sg.id
  referenced_security_group_id = aws_security_group.ecs_sg.id
  from_port                    = 6379
  to_port                      = 6379
  ip_protocol                  = "tcp"
}
