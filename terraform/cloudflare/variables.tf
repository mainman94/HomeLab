variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
  sensitive   = true
}

variable "cloudflare_domain" {
  description = "Cloudflare Domain"
  type        = string
  sensitive   = true
}

variable "CLOUDFLARE_ACCOUNT_ID" {
  description = "Cloudflare Account ID"
  type        = string
  sensitive   = true
}
variable "CLOUDFLARE_ZONE_ID_HAUPTMANN_DEV" {
  description = "Cloudflare Zone ID for hauptmann.dev"
  type        = string
  sensitive   = true
}

variable "public_ip" {
  description = "The public IP address for A records."
  type        = string
  default     = "84.115.110.237"
}

variable "a_records" {
  description = "A list of subdomains for A records."
  type        = set(string)
  default = [
    "audiobookshelf",
    "auth",
    "bookstack",
    "git",
    "grafana",
    "immich",
    "jellyfin",
    "jellyseerr",
    "n8n",
    "nc",
    "paperless",
    "radarr",
    "rancher",
    "sonarr",
    "uptime",
    "vault",
  ]
}

variable "a_records_hauptmann_dev" {
  description = "A list of a records"
  type        = set(string)
  default = [
    "*.hauptmann.dev",
    "hauptmann.dev",
  ]
}

variable "cname_backend_records" {
  description = "A list of CNAME records for backend services."
  type        = set(string)
  default     = [
    "registry"
  ]
}

variable "CLOUDFLARE_TUNNEL_STRASSGANG_ID" {
  description = "Cloudflare Tunnel ID for Strassgang"
  type        = string
  sensitive   = true
}

variable "MY_EMAIL" {
  description = "Email address for MFA access policy"
  type        = string
}
