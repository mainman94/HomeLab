resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = var.pve_storage
  node_name    = var.pve_node_name

  source_file {
    path = "cloud-init/user-data.yml"
  }
}

resource "local_file" "ansible_inventory" {
#  count = length(proxmox_virtual_environment_vm.k8s_cp) > 0 && length(proxmox_virtual_environment_vm.k8s_worker) > 0 ? 1 : 0
  filename = var.ansible_k8s_cluster_inventory_path

content = <<-EOF
  %{ for i in range(var.control_plane_count) }
  k8s-cp-${i + 1} ansible_host=${proxmox_virtual_environment_vm.k8s_cp[i].ipv4_addresses[1][0]} ansible_user=ansible_user
  %{ endfor }
  %{ for i in range(var.worker_count) }
  k8s-worker-${i + 1} ansible_host=${proxmox_virtual_environment_vm.k8s_worker[i].ipv4_addresses[1][0]} ansible_user=ansible_user
  %{ endfor }
  [kube_control_plane]
  %{ for i in range(var.control_plane_count) }
  k8s-cp-${i + 1}
  %{ endfor }

  [etcd]
  %{ for i in range(var.control_plane_count) }
  k8s-cp-${i + 1}
  %{ endfor }

  [kube_node]
  %{ for i in range(var.worker_count) }
  k8s-worker-${i + 1}
  %{ endfor }
  EOF
}
