resource "proxmox_virtual_environment_vm" "k8s_cp" {
  count       = var.control_plane_count
  name        = "${var.pve_control_node_name}${count.index + 1}" 
  description = "Managed by Terraform"
  tags        = ["k8s"]
  node_name   = var.pve_node_name

  cpu {
    cores = 2
  }

  memory {
    dedicated = 8192
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = var.pve_storage_zfs
    file_id      = proxmox_virtual_environment_file.cloud_image_cluster.id
    interface    = "scsi0"
    size         = 32
  }

  serial_device {}

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
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

  provisioner "remote-exec" {
    when       = destroy
    on_failure = continue
    inline = [
      "cloud-init status --wait"
    ]
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("~/.ssh/id_rsa")
    host        = element(element(self.ipv4_addresses, index(self.network_interface_names, "eth0")), 0)
  }
}

resource "proxmox_virtual_environment_vm" "k8s_worker" {
  count       = var.worker_count
  name        = "${var.pve_worker_node_name}${count.index + 1}"   
  description = "Managed by Terraform"
  tags        = ["k8s"]
  node_name   = var.pve_node_name

  cpu {
    cores = 2
  }

  memory {
    dedicated = 12288
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = var.pve_storage_zfs
    file_id      = proxmox_virtual_environment_file.cloud_image_cluster.id
    interface    = "scsi0"
    size         = 50
  }

  serial_device {} 

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
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

  provisioner "remote-exec" {
    when       = destroy
    on_failure = continue
    inline = [
      "cloud-init status --wait"
    ]
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("~/.ssh/id_rsa")
    host        = element(element(self.ipv4_addresses, index(self.network_interface_names, "eth0")), 0)
  }

}