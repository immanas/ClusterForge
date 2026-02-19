# 🚀 ClusterForge — Multi-Environment GitOps Platform for Kubernetes:

A distributed multi-cluster Kubernetes system designed to manage multiple environments, where infrastructure provisioning, application deployment, scaling, and monitoring are fully automated using GitOps workflows, with built-in scalability and observability powered by Terraform, AWS EKS, and ArgoCD.

# 🧩 Problem vs Solution (Real-World Production Context)

| 🚨 Real-World Problem | ❌ What Typically Happens in Teams | ✅ ClusterForge Solution |
|-----------------------|-----------------------------------|--------------------------|
| 🌍 Dev works, Prod breaks | Dev and Prod clusters are configured slightly differently; bugs appear only after release | Terraform modules create identical, reproducible dev/prod/control clusters |
| 🔁 “Who changed this?” incidents | Engineers run `kubectl apply` manually; Git no longer reflects real cluster state | ArgoCD enforces Git as single source of truth with auto-sync + auto-prune |
| ⏳ Traffic drops during deployment | Pods are terminated before new ones are ready; users see downtime | Rolling update strategy with readiness & liveness probes |
| 📉 Application crashes during traffic spike | Static replica count; no autoscaling; manual intervention required | HPA dynamically adjusts replicas based on CPU metrics |
| 🔍 Incident debugging takes hours | Teams check only `kubectl logs`; no metrics visibility | Prometheus monitoring stack provides real-time metrics and observability |
| 🏗️ No one knows how infra was created | Click-ops in AWS console; no documentation; hard to recreate environments | Fully declarative Infrastructure as Code (Terraform) |
| 🔐 Over-permissioned IAM roles | Static credentials and broad policies increase security risk | IAM roles with least privilege + OIDC provider integration |
| 💥 Terraform destroy fails midway | Subnets, IGWs, NATs have hidden dependencies; cleanup becomes manual | Verified Terraform destroy with dependency resolution and teardown validation |
| 🌐 Flat networking causes exposure | All services share same subnet; poor isolation between workloads | Multi-AZ VPC with public/private subnet isolation |
| 📦 Dev accidentally affects Prod | Single cluster used for multiple environments | Dedicated EKS clusters per environment |
| 📊 Monitoring added after outage | Metrics and alerting introduced only after a production incident | Monitoring integrated as a core platform layer |
| 🔄 Cluster management chaos | Multiple clusters manually accessed and configured | Central control cluster managing environments via GitOps |

## 📂 Project Structure

The following represents the folder structure of the **ClusterForge Infrastructure Repository**, which is responsible for provisioning the VPC, IAM roles, and multi-environment EKS clusters using Terraform.

```
clusterforge-infra/
│
├── modules/  # Reusable Terraform modules
│
│   ├── vpc/  # VPC, subnets, routing, NAT, gateways
│   │   ├── main.tf        # Defines networking resources
│   │   ├── variables.tf   # CIDR, AZs, subnet configs
│   │   └── outputs.tf     # VPC ID, subnet IDs
│
│   ├── eks/  # EKS cluster + node groups
│   │   ├── main.tf        # EKS, node groups, IRSA
│   │   ├── variables.tf   # Cluster config inputs
│   │   └── outputs.tf     # Endpoint, OIDC, node details
│
│   └── iam/  # IAM roles and policies
│       ├── main.tf        # Roles, policies, OIDC trust
│       ├── variables.tf   # Role configs
│       └── outputs.tf     # Role ARNs
│
├── main.tf         # Root module wiring VPC, IAM, EKS
├── variables.tf    # Global configuration variables
├── outputs.tf      # Exported infrastructure outputs
├── providers.tf    # AWS provider configuration
├── backend.tf      # Remote state (S3 + DynamoDB)
├── README.md       # Project documentation
├── LICENSE         # License file
└── .gitignore      # Ignore local/terraform files

```

The application deployment layer of this project — including Kubernetes manifests, ArgoCD configuration, and the multi-environment GitOps workflow — is maintained in a separate repository.

🔗 **ClusterForge GitOps Repository:**  
https://github.com/immanas/clusterforge-gitops

##  🏗️ Architecture Diagram:


