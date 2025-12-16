# HomeLab MK2 - WIP

Infrastructure as Code for managing cloud services and DNS using Terraform.

## Overview

This repository contains Terraform configurations to manage:
- **Cloudflare DNS & Mail**: DNS records, email routing, and Cloudflare Tunnel configuration for the `hauptmann.dev` domain
- **Infisical Secrets Management**: Automated secret creation and management for application environments

## Project Structure

```
terraform/
├── cloudflare/          # Cloudflare DNS, mail, and tunnel configuration
│   ├── main.tf
│   ├── dns.tf          # A records and CNAME records
│   ├── mail.tf         # Email routing configuration
│   ├── provider.tf     # Cloudflare provider setup
│   ├── variables.tf    # Input variables
│   └── backend.tf      # State backend configuration
└── infisical/          # Infisical secrets management
    ├── main.tf         # Projects, workspaces, and secret resources
    ├── provider.tf     # Infisical provider setup
    ├── variables.tf    # Input variables
    └── backend.tf      # State backend configuration
```

## Prerequisites

- Terraform (or tofu/OpenTofu)
- Cloudflare account with API token
- Infisical account with API access
- Appropriate environment variables or `.tfvars` file configured

## Configuration

Before deploying, configure the required variables:
- Cloudflare API token and zone IDs
- Infisical API credentials
- Domain-specific settings (IP addresses, tunnel IDs, etc.)

## Deployment

1. Navigate to the desired Terraform module:
   ```bash
   cd terraform/cloudflare  # or terraform/infisical
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the planned changes:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## CI/CD

This repository includes GitHub Actions workflows for security scanning using `tfsec` to validate Terraform configurations.

## Dependencies

- Renovate is configured for automated dependency updates

## Notes

- This project is a Work in Progress (WIP)
- Terraform state is managed and stored (see `terraform.tfstate` and backend configurations)
- All sensitive values should be provided via environment variables or secure variable files
