variable "domain_name" {
  type = string
  description = "The domain name for the SSL certificate (e.g., moamiin.org)"
}

variable "hosted_zone_id" {
  type = string
  description = "The Route53 hosted zone ID for DNS validation"
}
