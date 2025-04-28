# HomeLab MK2

# Terraform Kubernetes Cluster on Proxmox

This repository provides Terraform scripts to provision a **Kubernetes cluster** on **Proxmox**.

## Overview
The project automates the following steps:
1. Creation of virtual machines on Proxmox using tofu
2. Configuration of the vms via Ansible
4. Setup of a Kubernetes cluster on the provisioned VMs
6. Adding a homepage

## Prerequisites
- Proxmox VE server with API access
- tofu with bgp/proxmox provider (https://github.com/bpg/terraform-provider-proxmox)
- Ansible

## Deployment
1. Ansible for vm templates. Check readme.md in the ansible directory
2. Tofu your vm´s. Make sure to change the variables in terraform/cluster/variables.tf. The PVE endpoint and the number on vm´s should be configured.