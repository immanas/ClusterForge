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

## 📈 Core Features:

| ✅ What This Project **IS** | ❌ What This Project is **NOT** |
|--------------------------|------------------------------|
| Multi-Environment Kubernetes Platform — Dev, Prod, and Control clusters running on Amazon EKS | Not a single-cluster Kubernetes demo |
| Infrastructure as Code (Terraform) — Fully provisioned VPC, IAM, and EKS using reusable modules | Not a static YAML-only deployment |
| Centralized GitOps Control Plane — ArgoCD manages application deployments across clusters | Not a CI/CD-only showcase without real infrastructure |
| 🚀 Production-Grade Deployment — NGINX with rolling updates, probes, and health checks | Not a local Minikube experiment |
| 📈 Auto-Scaling Enabled — Horizontal Pod Autoscaler (HPA) based on CPU metrics | Not a toy monitoring setup without scaling validation |
| 📊 Observability Integrated — Metrics Server + Prometheus + Grafana | Not a slide-based architecture without live proof |
| 🔐 Secure by Design — IAM roles, OIDC (IRSA), private subnets, controlled networking |  |
| 🧱 Modular & Scalable Architecture — Designed for real-world extensibility |  |

This project demonstrates a **real, deployable, multi-cluster cloud-native platform** — built and validated end-to-end.
## 🧰 Tech Stack:

This project combines Infrastructure as Code, Kubernetes orchestration, and GitOps-driven deployment to build a production-style multi-cluster platform.

### ☁ Cloud Platform
- **AWS (ap-south-1)** – Primary cloud provider
- **Amazon EKS** – Managed Kubernetes control plane
- **Amazon VPC** – Custom networking (public/private subnets, NAT, IGW)
- **IAM + OIDC (IRSA)** – Secure workload identity
- **KMS** – Encryption at rest for cluster secrets
- **CloudWatch** – Control plane logging
- **S3 + DynamoDB** – Terraform remote backend & state locking

### 🏗 Infrastructure as Code
- **Terraform (>= 1.5)** – Modular infrastructure provisioning
- Reusable modules: `vpc`, `eks`, `iam`
- Remote state management for safe multi-user workflows

### ☸ Container Orchestration
- **Kubernetes (EKS 1.29+)**
- **Managed Node Groups**
- **Horizontal Pod Autoscaler (HPA)**
- Rolling updates & self-healing deployments

### 🔁 GitOps & Deployment
- **ArgoCD** – Declarative multi-cluster GitOps controller
- Environment-based deployment model (Dev / Prod)
- Auto-sync + auto-prune enabled

### 📦 Application Layer
- **Docker** – Containerized Nginx application
- Kubernetes manifests:
  - Deployment
  - Service
  - HPA
  - Namespace

### 🛠 Tooling
- kubectl

## 📸 Infrastructure Proof

### 1️⃣ Multi-Environment EKS Clusters
![EKS Clusters](proof/eks-clusters.png)

---

### 2️⃣ Custom VPC Architecture
Public & private subnets across multiple AZs with proper routing.

![VPC Architecture](proof/vpc-architecture.png)

---

### 3️⃣ Worker Nodes (Managed Node Groups)
EKS-managed EC2 instances running in private subnets.

![EC2 Nodes](proof/ec2-nodes.png)

---

### 4️⃣ GitOps Deployment via ArgoCD
Applications synced and healthy across dev & prod clusters.

![ArgoCD Sync](proof/argocd-sync.png)

---

### 5️⃣ Horizontal Pod Autoscaling (HPA)
Dynamic scaling based on CPU metrics.

![HPA Scaling](proof/hpa-scaling.png)

## 🔄 Request Lifecycle:

***End-to-End Flow:***

1. Infrastructure provisioned via Terraform.
2. EKS clusters created (dev / prod / control).
3. ArgoCD deployed in control cluster.
4. ArgoCD connects to GitOps repo.
5. Application manifests synced to dev & prod clusters.
6. Kubernetes schedules pods on node groups.
7. HPA monitors CPU metrics and scales pods dynamically.
8. Traffic is served through Kubernetes Service.

***Why This Design?***

- Clear separation of infra and app layers.
- Multi-environment isolation.
- Git-driven declarative deployment.
- Production-aligned Kubernetes architecture.

## 🛡 Resilience & Security:

***Failure Scenarios***
- Node failure → Pods rescheduled automatically.
- Pod crash → Kubernetes self-healing restarts container.
- High traffic → HPA scales replicas.
- Terraform drift → Reconciliation via `terraform apply`.

***Security Considerations***
- Private subnets for worker nodes.
- IAM least-privilege roles.
- IRSA for workload identity.
- Encrypted EKS secrets via KMS.
- Remote state locking via DynamoDB.

***Scalability & Performance***
- Managed node group scaling.
- Horizontal Pod Autoscaler.
- Multi-AZ subnet distribution.
- Stateless application design.

## ⚙ Engineering Philosophy:

***Trade-offs & Decisions***
- Chose EKS over self-managed Kubernetes for reliability.
- Separated infra and GitOps repos for ownership clarity.
- Used managed node groups for operational simplicity.
- Prioritized reproducibility over manual console setup.

***Explicit Limitations***
- No production-grade ingress controller (for simplicity).
- No service mesh implemented.
- Monitoring stack optional (not hardened for production).

### 🙌 Contributions Welcome!
ClusterForge is an open-source initiative, and we welcome contributions from developers, data scientists, cloud engineers, and Devops enthusiasts!

### 💡 Ideas You Can Work On:

- Add production-grade Ingress + ALB.
- Integrate full Prometheus/Grafana monitoring.
- Implement CI validation for Terraform plans.
- Add cost optimization policies.
- Introduce blue/green deployment strategy.

### 🛠️ How to Contribute:
- 🍴 Fork the repo
- 📦 Create a new feature branch: ```git checkout -b feature-name```
- ✅ Make your changes and test them
- 📬 Submit a pull request describing your enhancement
- 🤝 Let's Build This Together! Made with 💚 by Manas Gantait

