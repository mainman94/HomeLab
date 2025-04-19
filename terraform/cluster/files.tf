resource "proxmox_virtual_environment_file" "cloud_image_cluster" {
  content_type = "iso"
  datastore_id = var.pve_storage
  node_name    = var.pve_node_name

  source_file {
    path      = "https://cloud-images-archive.ubuntu.com/releases/noble/release-20240423/ubuntu-24.04-server-cloudimg-amd64.img"
    file_name = "oracular-server-cloudimg-amd64_cluster.img"
    checksum  = "32a9d30d18803da72f5936cf2b7b9efcb4d0bb63c67933f17e3bdfd1751de3f3"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = var.pve_storage
  node_name    = var.pve_node_name

  source_file {
    path = "cloud-init/user-data.yml"
  }
}

resource "local_file" "ansible_inventory" {
  filename = "~/inventory.ini"

content = <<-EOF
  %{ for i in range(var.control_plane_count) }
  k8s-cp-${i + 1} ansible_host=${proxmox_virtual_environment_vm.k8s_cp[i].ipv4_addresses[1][0]} ansible_user=root
  %{ endfor }
  %{ for i in range(var.worker_count) }
  k8s-worker-${i + 1} ansible_host=${proxmox_virtual_environment_vm.k8s_worker[i].ipv4_addresses[1][0]} ansible_user=root
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

#k8s-cp-01 ansible_host=192.168.0.127 ansible_user=root
#k8s-worker-01 ansible_host=192.168.0.163 ansible_user=root
#k8s-worker-02 ansible_host=192.168.0.187 ansible_user=root


#[kube_control_plane]
#k8s-cp-01

#[etcd]
#k8s-cp-01

#[kube_node]
#k8s-worker-01
#k8s-worker-02
}
