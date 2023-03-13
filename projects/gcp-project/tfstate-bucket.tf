# define GCP region
variable "gcp_region" {
  type        = string
  description = "GCP region"
}
# define GCP project name
variable "gcp_project" {
  type        = string
  description = "GCP project name"
}
variable "storage-class" {
  type        = string
  description = "The storage class of the Storage Bucket to create"
}
variable "candidate" {
  type        = string
  description = "Name of Candidate"
}

# Create a GCS Bucket for backend - UAT
resource "google_storage_bucket" "tf-state-bucket__uat" {
  project       = var.gcp_project
  name          = "${var.candidate}-${var.gcp_project}-tfstate-uat"
  location      = var.gcp_region
  force_destroy = true
  storage_class = var.storage-class
  versioning {
    enabled = true
  }
}

# Create a GCS Bucket for backend - PROD
resource "google_storage_bucket" "tf-state-bucket__prod" {
  project       = var.gcp_project
  name          = "${var.candidate}-${var.gcp_project}-tfstate-prod"
  location      = var.gcp_region
  force_destroy = true
  storage_class = var.storage-class
  versioning {
    enabled = true
  }
}
