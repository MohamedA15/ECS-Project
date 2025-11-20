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
