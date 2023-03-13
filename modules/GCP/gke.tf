data "google_service_account" "terraform__service_account" {
  account_id = "105675266855924642959"
}

/******************************************
  Create Container Cluster
 *****************************************/
resource "google_container_cluster" "gke-primary" {
  provider = google

  name       = "${var.environment}-${var.candidate}-gke"
  project    = var.project
  location   = var.region
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  release_channel {
    channel = var.release_channel
  }

  cost_management_config {
    enabled = var.enable_cost_allocation
  }

  # only one of logging/monitoring_service or logging/monitoring_config can be specified
  monitoring_config {
    enable_components = []

    managed_prometheus {
      enabled = var.monitoring_enable_managed_prometheus
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = 1
}

/******************************************
  Create Container Cluster node pools
 *****************************************/
resource "google_container_node_pool" "node-pools" {
  provider = google
  name     = "${var.environment}-${var.candidate}-gke-node-pool--managed"
  project  = var.project
  location = var.region
  cluster  = google_container_cluster.gke-primary.name
  version  = google_container_cluster.gke-primary.min_master_version

  initial_node_count = 1
  node_count         = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 100
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  node_config {
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-medium"

    tags = ["gke-node", "${var.candidate}-${var.project}-gke-node-pool--managed"]

    local_ssd_count = 0
    disk_size_gb    = 100
    disk_type       = "pd-standard"

    preemptible     = false
    service_account = data.google_service_account.terraform__service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

}
