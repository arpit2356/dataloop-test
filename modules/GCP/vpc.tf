resource "google_compute_network" "vpc" {
  name                    = "${var.environment}-${var.candidate}-${var.project}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.environment}-${var.candidate}-${var.project}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.1.1.0/24"
}
