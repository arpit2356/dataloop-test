output "endpoint" {
  sensitive   = true
  description = "Cluster endpoint"
  value       = google_container_cluster.gke-primary.endpoint
  depends_on = [
    google_container_cluster.gke-primary,
    google_container_node_pool.node-pools,
  ]
}
