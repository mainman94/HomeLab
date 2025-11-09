############################################
# Zero Trust Access Application
############################################
resource "cloudflare_zero_trust_access_application" "seaweedfs_filer" {
  account_id           = var.CLOUDFLARE_ACCOUNT_ID
  name                 = "SeaweedFS Filer (HTTPS)"
  domain               = "sftp.philippmhauptmann.me"
  type                 = "self_hosted"
  session_duration     = "24h"
  app_launcher_visible = true
  logo_url             = "https://seaweedfs.github.io/seaweedfs/seaweedfs_small.png"

  # Policies werden über IDs zugewiesen (Reihenfolge via precedence im Array)
  policies = [
    { id = cloudflare_zero_trust_access_policy.mfa_email.id },
    { id = cloudflare_zero_trust_access_policy.service_token.id }
  ]
}

############################################
# Service Token für TrueNAS
############################################
resource "cloudflare_zero_trust_access_service_token" "truenas_seaweedfs" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "TrueNAS-SeaweedFS-Mount-Automatic"
}

############################################
# Policies
############################################

# 🔐 Menschlicher Zugriff mit MFA
resource "cloudflare_zero_trust_access_policy" "mfa_email" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "Allow Humans with MFA"
  decision   = "allow"

  include = [
    {
      email = {
        email = "deine.email@beispiel.de"
      }
    }
  ]

  require = [
    {
      mfa = {}
    }
  ]
}

# 🤖 Service Token ohne MFA
resource "cloudflare_zero_trust_access_policy" "service_token" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "Allow TrueNAS Service Token (no MFA)"
  decision   = "allow"

  include = [
    {
      service_token = {
        token_id = cloudflare_zero_trust_access_service_token.truenas_seaweedfs.id
      }
    }
  ]
}

############################################
# Outputs (Service Token)
############################################
output "SERVICE_TOKEN_CLIENT_ID" {
  value     = cloudflare_zero_trust_access_service_token.truenas_seaweedfs.client_id
  sensitive = true
}

output "SERVICE_TOKEN_CLIENT_SECRET" {
  value     = cloudflare_zero_trust_access_service_token.truenas_seaweedfs.client_secret
  sensitive = true
}
