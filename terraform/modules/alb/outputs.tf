output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "https_listener_arn" {
  value = aws_lb_listener.https_listener.arn
}
