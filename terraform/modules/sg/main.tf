// ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Security group for the Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.alb_sg_name
  }
}

# HTTP (80)
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.allow_http_from_cidr
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# HTTPS (443)
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.allow_https_from_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_sg_name
  description = "Security group for ECS Fargate tasks"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.ecs_sg_name
  }
}

# Allow ALB to reach ECS on port 80
resource "aws_vpc_security_group_ingress_rule" "ecs_ingress_from_alb" {
  security_group_id            = aws_security_group.ecs_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

# Allow ECS tasks to talk out to the internet (for updates, APIs, etc.)
resource "aws_vpc_security_group_egress_rule" "ecs_egress_all" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
