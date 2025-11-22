terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  dvo = tolist(aws_acm_certificate.cert.domain_validation_options)[0]
}

resource "cloudflare_record" "acm_validation" {
  zone_id = var.cloudflare_zone_id

  name    = local.dvo.resource_record_name
  type    = local.dvo.resource_record_type
  value   = local.dvo.resource_record_value
  ttl     = 60
  proxied = false
}

resource "aws_acm_certificate_validation" "validate" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [cloudflare_record.acm_validation.hostname]
}
