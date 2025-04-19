# HomeLab MK1

# Terraform Kubernetes Cluster on Proxmox with WordPress

This repository provides Terraform scripts to provision a **Kubernetes cluster** on **Proxmox** and deploy a **WordPress site** on the cluster.

## Overview
The project automates the following steps:
1. Creation of virtual machines on Proxmox using tofu. This machine works as a pipeline and is able to execute GitHub Actions.
2. 
3. Setup of a Kubernetes cluster on the provisioned VMs.
4. Deployment of a WordPress instance using Helm.
5. Adding a homepage

## Prerequisites
- Proxmox VE server with API access
- tofu with bgp/proxmox provider (https://github.com/bpg/terraform-provider-proxmox)
- Kubespray (https://github.com/kubespray/kubespray)
