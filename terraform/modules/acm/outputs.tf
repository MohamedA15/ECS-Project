output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
  description = "The ARN of the validated ACM certificate"
}
