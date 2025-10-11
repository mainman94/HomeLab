# Erstelle ein Infisical-Projekt (falls nicht vorhanden)
resource "infisical_project" "my_app" {
  name        = "MyApp"
  description = "Beispiel-Projekt für Terraform-Integration"
}

# Erstelle einen Workspace im Projekt
resource "infisical_workspace" "dev" {
  project_id = infisical_project.my_app.id
  name       = "dev"
  slug       = "dev"  # Environment-Slug
}

# Erstelle einen Folder für Secrets
resource "infisical_folder" "secrets" {
  workspace_id = infisical_workspace.dev.id
  name         = "database"
  path         = "/database"  # Pfad für Organisation
}

# Generiere ein zufälliges Passwort (z. B. 16 Zeichen, mit Sonderzeichen)
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()_+"  # Erlaubte Sonderzeichen
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1

  # Optional: Keeper, um Passwort bei jedem Run neu zu generieren (standardmäßig behalten)
  keepers = {
    # Wenn du es rotieren möchtest, z. B. bei Änderung eines Tags
  }
}

# Setze das Secret in Infisical
resource "infisical_secret" "db_pass" {
  workspace_id = infisical_workspace.dev.id
  folder_id    = infisical_folder.secrets.id
  key          = "DB_PASSWORD"
  value        = random_password.db_password.result  # Generierter Wert!
  description  = "Zufälliges DB-Passwort für Dev-Env"
}