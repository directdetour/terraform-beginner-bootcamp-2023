terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
#   cloud {
#     organization = "myoung_multicloud"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
}

provider "aws" {
  # Configuration options
}