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
  description = "PVE endpoint URL"
  type        = string
  default     = "https://lab-pve.philippmhauptmann.me:8006/api2/json"
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
  default = 0
}

variable "pve_cp_template_id" { 
  type    = number
  default = 9001
}

variable "pve_worker_template_id" { 
  type    = number
  default = 9002
}

variable "pve_vault_template_id" { 
  type    = number
  default = 9003
}

variable "pve_storage" {
  description = "PVE local storage name"
  type        = string
  default     = "local"
}

variable "pve_storage_zfs" {
  description = "PVE local zfs storage name"
  type        = string
  default     = "storage"
}

variable "pve_node_name" {
  description = "PVE node name"
  type        = string
  default     = "lab-pve"
}

variable "local_backend_path" {
  description = "Path to local backend state file"
  type        = string
  default     = "C:/Users/phaup/work/terraform.tfstate"
}


variable "ansible_k8s_cluster_inventory_path" {
  description = "Path to local bak8s clsuter inventory file"
  type        = string
  default     = "C:/Users/phaup/work/HomeLab/ansible/ha-k3s/inventory/k8s-cluster-inventory.ini"
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

variable "vault_ip_address" {
  description = "The starting IP number for the VMs"
  type        = string
  default     = "192.168.0.249"
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