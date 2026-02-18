# 🚀 ClusterForge — Multi-Environment GitOps Platform for Kubernetes

A distributed multi-cluster Kubernetes system designed to manage multiple environments, where infrastructure provisioning, application deployment, scaling, and monitoring are fully automated using GitOps workflows, with built-in scalability and observability powered by Terraform, AWS EKS, and ArgoCD.


##  🥇 One-Line Over-view :

**ClusterForge** is a multi-cluster Kubernetes platform that enables **declarative infrastructure + GitOps-driven application delivery** with built-in scalability and observability.

## 🚨 Problem Statement (Real-World Context)

| Problem Area              | Real-World Issue                                                                 | Impact                                                                 |
|--------------------------|----------------------------------------------------------------------------------|------------------------------------------------------------------------|
| Multi-Environment Drift  | Dev, staging, and prod environments diverge over time                           | Inconsistent deployments, hard-to-debug failures                      |
| Manual Deployments       | Engineers deploy apps manually or via scripts                                   | Error-prone, non-reproducible releases                                |
| Lack of Central Control  | No unified control plane across clusters                                        | Poor visibility and fragmented operations                             |
| Scaling Challenges       | Applications don’t auto-scale efficiently                                       | Resource wastage or downtime under load                               |
| Weak Observability       | Metrics and monitoring are not standardized                                     | Delayed incident detection and poor debugging                         |

---

##  💡 Solution Overview

| Solution Component        | Approach Implemented                                                                 | Outcome                                                                 |
|--------------------------|--------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| GitOps Control Plane     | Central ArgoCD cluster managing multiple environments                               | Declarative, automated deployments across clusters                      |
| Infrastructure as Code   | Terraform used for VPC, IAM, and EKS provisioning                                   | Reproducible and version-controlled infrastructure                      |
| Multi-Cluster Strategy   | Separate dev, prod, and control clusters                                            | Environment isolation with centralized governance                       |
| Auto Scaling             | Horizontal Pod Autoscaler (HPA) based on CPU metrics                                | Dynamic scaling based on workload                                       |
| Observability Stack      | Prometheus-based monitoring via Helm                                                | Real-time metrics and system visibility                                 |

---

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


