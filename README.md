# dataloop-test

Terraform is an infrastructure as code tool that allows developers to define and provision infrastructure using a high-level configuration language. Google Kubernetes Engine (GKE) is a managed container orchestration service that makes it easy to deploy, manage, and scale containerized applications using Kubernetes.

To install Terraform, follow the instructions below:

1. Download the appropriate package for your operating system from the [official Terraform website](https://www.terraform.io/downloads.html).
2. Extract the downloaded package into a directory of your choice.
3. Add the directory to your system's `PATH` environment variable. This will allow you to run the `terraform` command from any directory in your terminal.
4. Also from package managers like Homebrew.


To deploy a GKE cluster using Terraform, navigate to environment specific directory (uat | production ) and run:
* `terraform init`
* `terraform plan`
* `terrafrom apply`

The most essential variables are in `terraform.tfvars`, Please change the values if required:
```hcl
# GCP Settings
gcp_project = "dataloop-candidate-environment"
gcp_region  = "asia-east1"
candidate   = "arpit"
```
It defines variables for a Google Cloud Platform (GCP) project, GCP region, and a candidate's name. Specifically, the GCP project is set to "dataloop-candidate-environment", the GCP region is set to "asia-east1", and the candidate's name is set to "arpit".

---
## File Structure
```bash
├── modules
│   ├── AWS
│   │   ├── eks.tf
│   │   ├── provider | variables.tf
│   │   └── vpc.tf
│   ├── Azure
│   │   ├── aks.tf
│   │   ├── provider | variables.tf
│   │   └── vnet.tf
│   ├── GCP
│   │   ├── __k8s_grafana.tf
│   │   ├── __k8s_namespace.tf
│   │   ├── __k8s_nginx.tf
│   │   ├── __k8s_prometheus.tf
│   │   ├── gke.tf
│   │   ├── outputs.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   └── vpc.tf
│   └── OCI
│       ├── k8s.tf
│       ├── provider | variables.tf
│       └── vnet.tf
└── projects
    └── gcp-project
        ├── production
        │   ├── module.tf
        │   └── terraform.tfvars
        ├── terraform.tfvars
        ├── tfstate-bucket.tf
        └── uat
            ├── module.tf
            ├── terraform.tfstate
            ├── terraform.tfstate.backup
            └── terraform.tfvars
```
The given file structure contains two main directories:

- **modules**: This directory contains subdirectories for AWS, Azure, GCP, and OCI. Each subdirectory contains Terraform code for creating Kubernetes clusters in the respective cloud providers.
- **projects**: This directory contains Terraform code for a GCP project. It contains subdirectories for the production and user acceptance testing (UAT) environments.

### GCP

- **__k8s_grafana.tf**: This Terraform file contains code for creating Grafana in Kubernetes in GCP.
- **__k8s_namespace.tf**: This Terraform file contains code for creating a Namespace in Kubernetes in GCP.
- **__k8s_nginx.tf**: This Terraform file contains code for creating Nginx in Kubernetes in GCP.
- **__k8s_prometheus.tf**: This Terraform file contains code for creating Prometheus in Kubernetes in GCP.
- **gke.tf**: This Terraform file contains code for creating a Google Kubernetes Engine (GKE) in GCP.
- **outputs.tf**: This Terraform file contains output declarations for GCP GKE.
- **provider.tf**: This Terraform file contains provider declarations for GCP.
- **variables.tf**: This Terraform file contains variable declarations for GCP GKE.
- **vpc.tf**: This Terraform file contains code for creating a VPC in GCP.

### Projects

- **gcp-project**: This directory contains Terraform code for a GCP project.
    - **production**: This subdirectory contains Terraform code for the production environment of the GCP project.
        - **module.tf**: This Terraform file contains module declarations for the production environment.
        - **terraform.tfvars**: This Terraform file contains variable declarations for the production environment.
    - **uat**: This subdirectory contains Terraform code for the user acceptance testing (UAT) environment of the GCP project.
        - **module.tf**: This Terraform file contains module declarations for the UAT environment.
        - **terraform.tfstate**: This Terraform file contains the Terraform state file for the UAT environment.
    - **terraform.tfvars**: This Terraform file contains variable declarations for the GCP project.
    - **tfstate-bucket.tf**: This Terraform file contains code for creating a Terraform state bucket in GCP.
---

## Terraform Backend / remote state

I have kept the state file in local FS only but state can also be stored in a GCS bucket by:

* Applying terrafrom in directory `gcp-project` which contains `tfstate-bucket.tf` file.
* Uncommenting backend code block from `module.tf` in each env specific directory.

```hcl
#terraform {
#  backend "gcs" {
#    bucket = "<uat bucket created from previous directory>"
#    prefix = "terraform/state"
#  }
#}
```
---

I have made an effort to ensure that the execution of assignment and content of this document is straightforward and easy to understand. However, I am always open to suggestions for improvement. Therefore, I would greatly appreciate any feedback you may have that could help simplify or clarify the material presented.

Thank you in advance for your time and input.