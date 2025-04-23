resource "proxmox_virtual_environment_vm" "k8s_cp" {
  count     = var.control_plane_count
  name      = "${var.pve_control_node_name}${count.index + 1}"
  tags      = ["k8s", "control-plane"]
  node_name = var.pve_node_name

  clone {
    vm_id = 9001
  }

  initialization {
    datastore_id      = var.pve_storage_zfs
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

    ip_config {
      ipv4 {
        address = "${cidrhost(var.starting_ip, var.starting_ip_number - count.index)}${var.network_mask}"
        gateway = var.gateway_ip
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "k8s_worker" {
  count     = var.worker_count
  name      = "${var.pve_worker_node_name}${count.index + 1}"
  tags      = ["k8s", "worker"]
  node_name = var.pve_node_name

  clone {
    vm_id = 9002
  }

  initialization {
    datastore_id      = var.pve_storage_zfs
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

    ip_config {
      ipv4 {
        address = "${cidrhost(var.starting_ip, var.starting_ip_number + count.index + 1)}${var.network_mask}"
        gateway = var.gateway_ip
      }
    }
  }
}

# Vault Node
resource "proxmox_virtual_environment_vm" "vault" {
  count     = var.vault_node_count
  name      = "${var.pve_vault_node_name}${count.index + 1}"
  tags      = ["vault"]
  node_name = var.pve_node_name

  clone {
    vm_id = 9003
  }

  initialization {
    datastore_id      = var.pve_storage_zfs
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

    ip_config {
      ipv4 {
        address = "${cidrhost(var.starting_ip, var.starting_ip_number + 100 + count.index)}${var.network_mask}"
        gateway = var.gateway_ip
      }
    }
  }
}