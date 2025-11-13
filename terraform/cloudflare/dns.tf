#################################
#     A records for subdomains  #
#################################

resource "cloudflare_dns_record" "a_records" {
  for_each = var.a_records

  zone_id = var.cloudflare_zone_id
  name    = each.key
  content = var.public_ip
  type    = "A"
  ttl     = 1
  proxied = true
}

# A record for the root domain
resource "cloudflare_dns_record" "root_a" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  content = var.public_ip
  type    = "A"
  ttl     = 1
  proxied = true
}

# TXT records
resource "cloudflare_dns_record" "acme_challenge" {
  zone_id = var.cloudflare_zone_id
  name    = "_acme-challenge"
  content = "1Ss-MZc2d7XsQEMZcvN13KiFjzOuad7ot2PmewSUphc"
  type    = "TXT"
  ttl     = 120
}

resource "cloudflare_dns_record" "dmarc" {
  zone_id = var.cloudflare_zone_id
  name    = "_dmarc"
  content = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_dns_record" "dkim" {
  zone_id = var.cloudflare_zone_id
  name    = "*._domainkey"
  content = "v=DKIM1; p="
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_dns_record" "google_site_verification" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  content = "google-site-verification=MBJVgsnVJ8HojUM6pDZRRlvq1Mh9k-DDCmvEfQwuPyA"
  type    = "TXT"
  ttl     = 3600
}

resource "cloudflare_dns_record" "spf" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  content = "v=spf1 -all"
  type    = "TXT"
  ttl     = 1
}

################################
#  CNAME records for backend   #
################################
resource "cloudflare_dns_record" "cname_backend_records" {
  for_each = var.cname_backend_records

  zone_id = var.cloudflare_zone_id
  name    = each.key
  content = "${var.CLOUDFLARE_TUNNEL_STRASSGANG_ID}.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

#################################
#     A records hauptmann.dev   #
#################################

resource "cloudflare_dns_record" "a_records_hauptmann_dev" {
  for_each = var.a_records_hauptmann_dev

  zone_id = var.CLOUDFLARE_ZONE_ID_HAUPTMANN_DEV
  name    = each.key
  content = var.public_ip
  type    = "A"
  ttl     = 1
  proxied = true
}
