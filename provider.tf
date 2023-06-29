terraform {
  cloud {
    organization = "samuellee-dev"
    workspaces {
      name = "hcpv-plus-controlGroupDemo"
    }
  }
}

provider "hcp" {
  # client_id = "insert-service-principal-key-client-id"
  # client_secret = "insert-service-principal-key-client-secret"
}

provider "tfe" {}

provider "vault" {
  address = hcp_vault_cluster.hcpv-plus-controlGroupDemo.vault_public_endpoint_url
  token   = hcp_vault_cluster_admin_token.hcpv-plus-token.token
}
