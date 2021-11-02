resource "vault_mount" "kvv2-example" {
  path        = "version2-example"
  type        = "kv-v2"
  description = "This is an example KV Version 2 secret engine mount"
}


resource "vault_generic_secret" "example" {
  path = "version2-example"

  data_json = <<EOT
{
  "username":   "bar",
  "password": "cheese"
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
