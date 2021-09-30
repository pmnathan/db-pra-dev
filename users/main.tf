provider "vault" {
}

locals {
  raw_data  = jsondecode(file("${path.module}/users.json"))
  usernames = local.raw_data.users[*].username
}

module "main" {
  source    = "../modules/userentity"
  for_each  = toset(local.usernames)
  username  = each.key
  json_data = local.raw_data
}
