terraform {
  cloud {
    organization = "samuellee-dev"
    workspaces {
      name = "hcpv-cluster"
    }
  }
}

provider "hcp" {
  # client_id = "insert-service-principal-key-client-id"
  # client_secret = "insert-service-principal-key-client-secret"
}

provider "tfe" {}

provider "vault" {
  address = hcp_vault_cluster.hcpv-cluster.vault_public_endpoint_url
}
