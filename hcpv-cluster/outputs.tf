output "vault-token" {
  value     = hcp_vault_cluster_admin_token.hcpv-cluster-token.token
  sensitive = true
}

output "hcp-vault-id" {
  value = hcp_vault_cluster.hcpv-cluster.id
}

output "hcp-vault-address" {
  value = hcp_vault_cluster.hcpv-cluster.vault_public_endpoint_url
}
