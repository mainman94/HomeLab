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