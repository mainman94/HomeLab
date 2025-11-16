# 2. MX Records (konsolidiert)
resource "cloudflare_dns_record" "mx" {
  for_each = {
    "route1" = { server = "route1.mx.cloudflare.net", priority = 1 }
    "route2" = { server = "route2.mx.cloudflare.net", priority = 1 }
    "route3" = { server = "route3.mx.cloudflare.net", priority = 2 }
  }

  zone_id  = var.CLOUDFLARE_ZONE_ID_HAUPTMANN_DEV
  name     = var.cloudflare_domain
  type     = "MX"
  content  = each.value.server
  priority = each.value.priority
  ttl      = 1  # "auto"
}

# 3. Weiterleitungsregel (ALTE Syntax: Listen statt Blöcke)
resource "cloudflare_email_routing_rule" "forward_hello" {
  zone_id  = var.CLOUDFLARE_ZONE_ID_HAUPTMANN_DEV
  priority = 0
  matchers = [
    {
      type  = "literal"
      field = "to"
      value = "hello@${var.cloudflare_domain}"
    }
  ]

  # Actions als LISTE (nicht Block!)
  actions = [
    {
      type  = "forward"
      value = [var.MY_EMAIL]
    }
  ]

}