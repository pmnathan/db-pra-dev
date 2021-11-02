resource "vault_mount" "kvv2-example" {
  path        = "version2-example"
  type        = "kv-v2"
  description = "This is an example KV Version 2 secret engine mount"
}


resource "vault_generic_secret" "example" {
  path = "version2-example/static_db1"

  data_json = <<EOT
{
  "username":   "${var.db_username}",
  "password":   "${var.db_password}"
}
EOT
}


resource "vault_generic_secret" "example2" {
  path = "version2-example/static_db2"

  data_json = <<EOT
{
  "username":   "${var.db_username}",
  "password":   "${var.db_password}"
}
EOT
}


resource "vault_generic_secret" "example3" {
  path = "version2-example/static_apikey"

  data_json = <<EOT
{
  "api_key":   "${var.db_username}"
}
EOT
}





resource "vault_mount" "transit-example" {
  path        = "transit-example"
  type        = "transit"
  description = "This is an example transit secret engine mount"

  options = {
    convergent_encryption = false
  }
}
