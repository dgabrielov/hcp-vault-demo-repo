terraform {
  cloud {
    organization = "samuellee-dev"
    workspaces {
      name = "hcpv-control-group"
    }
  }
}

provider "hcp" {
  # client_id = "insert-service-principal-key-client-id"
  # client_secret = "insert-service-principal-key-client-secret"
}

provider "tfe" {}

provider "vault" {
  address = data.tfe_outputs.tfc-outputs.values.hcp-vault-address
  token   = data.tfe_outputs.tfc-outputs.values.vault-token
}
