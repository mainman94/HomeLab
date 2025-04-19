terraform {
  backend "local" {
    path = var.local_backend_path
  }
}