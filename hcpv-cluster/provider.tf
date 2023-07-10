terraform {
  cloud {
    organization = "samuellee-dev"
    workspaces {
      name = "hcpv-cluster"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {
  # client_id = "insert-service-principal-key-client-id"
  # client_secret = "insert-service-principal-key-client-secret"
  project_id = "5594ca7c-efd8-4ba6-bdbb-007bcf95cd84"
}

provider "tfe" {}

provider "vault" {
  address = hcp_vault_cluster.hcpv-cluster.vault_public_endpoint_url
}
