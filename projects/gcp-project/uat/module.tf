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
variable "candidate" {
  type        = string
  description = "Name of Candidate"
}

# Backend | remote state
/******************************************
  I was not sure if i had IAM access for creating bucket. Uncomment and can be used for backend.
 *****************************************/
#terraform {
#  backend "gcs" {
#    bucket = "<uat bucket created from previous directory>"
#    prefix = "terraform/state"
#  }
#}

# Defining module
module "gke-cluster" {
  source      = "../../../modules/GCP"
  candidate   = var.candidate
  project     = var.gcp_project
  region      = var.gcp_region
  environment = "uat"
}

# outputs
output "cluster_host" {
  value     = module.gke-cluster.endpoint
  sensitive = true
}
