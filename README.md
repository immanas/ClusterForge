# 🚀 ClusterForge — Multi-Environment GitOps Platform for Kubernetes

A distributed multi-cluster Kubernetes system designed to manage multiple environments, where infrastructure provisioning, application deployment, scaling, and monitoring are fully automated using GitOps workflows, with built-in scalability and observability powered by Terraform, AWS EKS, and ArgoCD.


##  🥇 One-Line Over-view :

**ClusterForge** is a multi-cluster Kubernetes platform that enables **declarative infrastructure + GitOps-driven application delivery** with built-in scalability and observability.

## 📂 Project Structure

The following represents the folder structure of the **ClusterForge infrastructure system**, organized to support reusable modules and environment-specific deployments:

```
clusterforge-infra/
│
├── modules/ # Reusable Terraform modules (core building blocks)
│ ├── vpc/ # VPC, subnets, routing, NAT, IGW
│ ├── eks/ # EKS cluster and node group provisioning
│ └── iam/ # IAM roles, policies, OIDC setup
│
├── envs/ # Environment-specific configurations
│ ├── dev/ # Development environment
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ │
│ ├── prod/ # Production environment
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ │
│ └── control/ # Control plane (ArgoCD cluster)
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
│
├── .gitignore # Ignored files and state
└── README.md # Project documentation
```

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


##  🏗️ Architecture Diagram:

```
            +----------------------+
            |     Git Repository   |
            | (K8s Manifests)      |
            +----------+-----------+
                       |
                       v
            +----------------------+
            |   ArgoCD (Control)   |
            |  GitOps Controller   |
            +----------+-----------+
                       |
     -----------------------------------------
     |                                       |
     v                                       v
+----------------------+ +----------------------+
| Dev EKS Cluster | | Prod EKS Cluster |
| - Nginx Deployment | | - Nginx Deployment |
| - HPA Enabled | | - HPA Enabled |
+----------+-----------+ +----------+-----------+
| |
v v
+------------+ +------------+
| Prometheus | | Prometheus |
+------------+ +------------+

```


