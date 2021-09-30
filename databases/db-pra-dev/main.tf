provider "vault" {
}

resource "vault_mount" "db_pra" {
  path = "db-pra"
  type = "database"
}

resource "vault_database_secret_backend_connection" "mysql" {
  backend       = vault_mount.db_pra.path
  name          = "mysql"
  allowed_roles = ["*"]
  mysql {
    connection_url    = "root:test123@tcp(localhost:3306)/"
    username_template = "{{.DisplayName | replace \"@hashicorp.com\" \"\" }}-{{.RoleName}}-{{unix_time}}-{{random 8}}"
  }
}

locals {
  raw_data = jsondecode(file("${path.module}/role-assignments.json"))
  roles    = local.raw_data.entitlements[*].role
}

module "main" {
  source   = "../../modules/dbroleuserpolicy"
  for_each = toset(local.roles)

  json_data    = local.raw_data
  role_name    = each.key
  backend_path = vault_mount.db_pra.path
  db_name      = vault_database_secret_backend_connection.mysql.name
}


