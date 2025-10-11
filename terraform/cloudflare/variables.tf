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
  default     = "80.109.202.7"
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
    "minio",
    "n8n",
    "nc",
    "paperless",
    "radarr",
    "rancher",
    "s3",
    "sonarr",
    "uptime",
    "vault",
  ]
}