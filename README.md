# HomeLab MK1

# Terraform Kubernetes Cluster on Proxmox

This repository provides Terraform scripts to provision a **Kubernetes cluster** on **Proxmox**.

## Overview
The project automates the following steps:
1. Creation of virtual machines on Proxmox using tofu.
2. Configuration of the vms via Ansible
4. Setup of a Kubernetes cluster on the provisioned VMs.
6. Adding a homepage

## Prerequisites
- Proxmox VE server with API access
- tofu with bgp/proxmox provider (https://github.com/bpg/terraform-provider-proxmox)
- Ansible
- k3s
