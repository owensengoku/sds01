terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 4.36.0, < 5.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.42.0, < 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {}