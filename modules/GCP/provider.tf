terraform {
  required_version = ">=0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.51.0, < 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.10"
    }
  }
  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-kubernetes-engine/v25.0.0"
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

provider "kubernetes" {
  host                   = google_container_cluster.gke-primary.endpoint
  client_certificate     = google_container_cluster.gke-primary.master_auth.0.client_certificate
  client_key             = google_container_cluster.gke-primary.master_auth.0.client_key
  cluster_ca_certificate = google_container_cluster.gke-primary.master_auth.0.cluster_ca_certificate
}
