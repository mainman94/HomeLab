resource "cloudflare_dns_record" "txt_spf" {
  zone_id = var.CLOUDFLARE_ZONE_ID_HAUPTMANN_DEV
  name    = var.cloudflare_domain
  type    = "TXT"
  content = "\"v=spf1 include:_spf.mx.cloudflare.net ~all\""
  ttl     = 1
}

resource "cloudflare_dns_record" "txt_dkim" {
  zone_id = var.CLOUDFLARE_ZONE_ID_HAUPTMANN_DEV
  name    = "cf2024-1._domainkey.hauptmann.dev"
  type    = "TXT"
  content = var.cloudflare_dkim_key
  ttl     = 1
}

resource "cloudflare_email_routing_rule" "forward_hello" {
  name     = "hello"
  zone_id  = var.CLOUDFLARE_ZONE_ID_HAUPTMANN_DEV
  priority = 0
  matchers = [
    {
      type  = "literal"
      field = "to"
      value = "hello@${var.cloudflare_domain}"
    }
  ]

  actions = [
    {
      type  = "forward"
      value = [var.MY_EMAIL]
    }
  ]

}