terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.52.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.5.0"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}
