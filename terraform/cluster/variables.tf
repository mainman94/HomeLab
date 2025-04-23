#Settings these via env.bat

variable "pve_username" {
  description = "PVE administrator username"
  type        = string
  sensitive   = true
  default     = "root@pam"
}

variable "pve_password" {
  description = "PVE administrator password"
  type        = string
  sensitive   = true
}

variable "pve_endpoint" {
  description = "PVE endpoint "
  type        = string
  default     = "https://pve.philippmhauptmann.me:8006/api2/json"
}

variable "pve_private_key" {
  description = "The path to the private key file for the PVE "
  type        = string
  sensitive   = true
}

variable "control_plane_count" {
  type    = number
  default = 3
}

variable "worker_count" {
  type    = number
  default = 1
}

variable "pve_storage" {
  description = "PVE local storage name"
  type        = string
  default     = "local"
}

variable "pve_storage_zfs" {
  description = "PVE local zfs storage name"
  type        = string
  default     = "zfs_storage"
}

variable "pve_node_name" {
  description = "PVE node name"
  type        = string
  default     = "pve"
}

variable "local_backend_path" {
  description = "Path to local backend state file"
  type        = string
  default     = "~/terraform.tfstate"
}

variable "pve_worker_node_name" {
  description = "PVE node name"
  type        = string
  default     = "k8s-worker-"
}

variable "pve_control_node_name" {
  description = "PVE node name"
  type        = string
  default     = "k8s-cp-"
}

variable "starting_ip" {
  description = "The starting IP address for the VMs"
  type        = string
  default     = "192.168.0.200/24"
}

variable "starting_ip_number" {
  description = "The starting IP number for the VMs"
  type        = string
  default     = "200"
}

variable "gateway_ip" {
  description = "The gateqay IP address for the VMs"
  type        = string
  default     = "192.168.0.2"
}

variable "network_mask" {

  description = "The network mask for the VMs"
  type        = string
  default     = "/24"
}