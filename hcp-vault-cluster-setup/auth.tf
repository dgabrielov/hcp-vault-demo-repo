resource "vault_auth_backend" "userpass" {
    type = "userpass"
}

resource "vault_generic_endpoint" "bob" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/bob"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["dev"],
  "password": "Demo1234"
}
EOT
}

resource "vault_generic_endpoint" "bob_token" {
  depends_on     = [vault_generic_endpoint.bob]
  path           = "auth/userpass/login/bob"
  disable_read   = true
  disable_delete = true

  data_json = <<EOT
{
  "password": "Demo1234"
}
EOT
}
#test
resource "vault_generic_endpoint" "bob_entity" {
  depends_on           = [vault_generic_endpoint.bob_token]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/lookup/entity"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "alias_name": "bob",
   "alias_mount_accessor": vault_auth_backend.userpass.accessor
  })
}

resource "vault_generic_endpoint" "bob_entity_name" {
  depends_on           = [vault_generic_endpoint.bob_entity]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/entity/id/${vault_generic_endpoint.bob_entity.write_data["id"]}"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "name": "bob"
  })
}

resource "vault_generic_endpoint" "ellen" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/ellen"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["manager"],
  "password": "Demo1234"
}
EOT
}

resource "vault_generic_endpoint" "ellen_token" {
  depends_on     = [vault_generic_endpoint.ellen]
  path           = "auth/userpass/login/ellen"
  disable_read   = true
  disable_delete = true

  data_json = <<EOT
{
  "password": "Demo1234"
}
EOT
}

resource "vault_generic_endpoint" "ellen_entity" {
  depends_on           = [vault_generic_endpoint.ellen_token]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/lookup/entity"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "alias_name": "ellen",
   "alias_mount_accessor": vault_auth_backend.userpass.accessor
  })
  
}

resource "vault_generic_endpoint" "ellen_entity_name" {
  depends_on           = [vault_generic_endpoint.ellen_entity]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/entity/id/${vault_generic_endpoint.ellen_entity.write_data["id"]}"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "name": "ellen"
  })
}

resource "vault_identity_group" "manager" {
  name                        = "manager"
  type                        = "internal"
  external_member_entity_ids  = true

}

resource "vault_identity_group_member_entity_ids" "manager-members" {
  exclusive         = true
  member_entity_ids = [vault_generic_endpoint.ellen_entity.write_data["id"]]
  group_id          = vault_identity_group.manager.id
}