# HCP Vault Cluster Setup

This repo contains demos built around HCP Vault. This repo aims to assist with standing up your own HCP Vault environment, with a few configurations to automatically test other features and capabilities of HCP Vault. Note that the way this repo aims to be build, is that you can copy the _demo-func.tf_ file into any of the directories to combine features and do a single HCP Vault deployment.

## Table of Contents

- [Project Title](#project-title)
- [Description](#description)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)

## Description

hcp-vault-cluster file contains all the terraform configs needed to automatically deploy your own HCP Cluster with a few HCP Vault features and functionalities, depending on what you're interested in

## Features

This Repo will help you stand up the following:

- 1x Vault Cluster

## Installation

This repo was built with Terraform Cloud in mind, but Terraform OSS should operate fine as well.

Ensure that you have created a [Service Principal](https://developer.hashicorp.com/hcp/docs/hcp/security/service-principals#create-a-service-principal) in HashiCorp Cloud Platform.

You will need to set the following variables:

| Name              | Location         |
| ----------------- | ---------------- |
| HCP_CLIENT_ID     | provider.tf      |
| HCP_CLIENT_SECRET | provider.tf      |
| region            | variables.tfvars |
| hcpv_name         | variables.tfvars |
| cloud_provider    | variables.tfvars |
| tier              | variables.tfvars |

_Note: If you're using terraform variables, replace the value in the provider.tf file, otherwise set these as env variables_

## Usage

TBC

## Contributing

Shoutout to Jamie Wright for the inspiration
