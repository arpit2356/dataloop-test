# Vars for use in provider
variable "region" {
  description = "region"
  default     = ""
}

variable "environment" {
  type        = string
  default     = ""
  description = "UAT | PROD"
}
variable "project" {
  description = "Project ID"
  default     = ""
}

variable "candidate" {
  description = "Name of Candidate"
  default     = ""
}

variable "enable_cost_allocation" {
  type        = bool
  description = "Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery"
  default     = false
}

variable "release_channel" {
  description = "Provide more control over automatic upgrades of your GKE cluster."
  default     = "STABLE"
}

variable "monitoring_enable_managed_prometheus" {
  type        = bool
  description = "Configuration for Managed Service for Prometheus. Whether or not the managed collection is enabled."
  default     = true
}

variable "maintenance_start_time" {
  type        = string
  description = "Time window specified for daily or recurring maintenance operations in RFC3339 format"
  default     = "05:00"
}

variable "maintenance_end_time" {
  type        = string
  description = "Time window specified for recurring maintenance operations in RFC3339 format"
  default     = ""
}

variable "maintenance_recurrence" {
  type        = string
  description = "Frequency of the recurring maintenance window in RFC5545 format."
  default     = ""
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Remove default node pool while setting up the cluster"
  default     = true
}
