locals {
  department    = [for e in var.json_data.users : e.department if e.username == var.username][0]
  email    = [for e in var.json_data.users : e.email if e.username == var.username][0]
  policy  = ""
}



data "vault_auth_backend" "azure_oidc" {
  path = "oidc"
}

/*resource "vault_policy" "main" {
  name = "${local.department}_${var.username}"
  policy = local.policy
}*/

resource "vault_identity_entity" "main" {
  name      = var.username
  //policies  = [vault_policy.main.name]
  metadata  = {
    department = local.department
  }
}

resource "vault_identity_entity_alias" "main" {
  name            = local.email
  mount_accessor  = data.vault_auth_backend.azure_oidc.accessor
  canonical_id    = vault_identity_entity.main.id
}

