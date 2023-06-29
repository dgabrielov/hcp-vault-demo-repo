# HCP Vault Control Group Demo

This repo contains a HCP Vault Control Group Demo that aims to assist with standing up your own HCP Vault environment, with a few configurations to automatically test the Control Group functionality.

## Table of Contents

- [Project Title](#project-title)
- [Description](#description)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)

## Description

HashiCorp Vault Control groups add additional authorization factors to be required before processing requests to increase the governance, accountability, and security of your secrets. When a control group is required for a request, the requesting client receives the wrapping token in return. Only when all authorizations are satisfied, the wrapping token can be used to unwrap the requested secrets.

## Features

This Repo will help you stand up the following:

- 3x Entities (Adam, Anna, Sam)
- 3x Secret Paths (dev, test, prod)
- 2x Policies (dev, manager)

## Installation

This repo was built with Terraform Cloud in mind, but Terraform OSS should operate fine as well.

You will need to set the following variables:

| Name                 | Location         |
| -------------------- | ---------------- |
| org_name             | variables.tfvars |
| vault_workspace_name | variables.tfvars |
| workspace_name       | variables.tfvars |

_Note: If you're using terraform variables, replace the value in the provider.tf file, otherwise set these as env variables_

## Usage

TBC

## Contributing

Shoutout to Jamie Wright for the inspiration, and also for helping write the bash script needed to monitor the log outputs.
