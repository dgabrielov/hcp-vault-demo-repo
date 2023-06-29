output "vault-token" {
  value     = hcp_vault_cluster_admin_token.hcpv-plus-token.token
  sensitive = true
}

output "hcp-vault-id" {
  value = hcp_vault_cluster.hcpv-plus-controlGroupDemo.id
}

output "hcp-vault-address" {
  value = hcp_vault_cluster.hcpv-plus-controlGroupDemo.vault_public_endpoint_url
}

#test
