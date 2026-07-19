# AWS EKS DevOps Platform

A production-inspired DevOps platform built on **AWS EKS** using **Terraform**, **GitHub Actions**, **Docker**, **Helm**, **Prometheus**, **Grafana**, and **Loki**.

This project demonstrates Infrastructure as Code (IaC), Kubernetes deployment, CI/CD automation, observability, security best practices, and AWS cloud infrastructure.

---

# Project Overview

This project automates the deployment of a containerized Node.js application on Amazon EKS using Terraform and GitHub Actions.

The platform includes:

- Infrastructure provisioning using Terraform
- Kubernetes deployment using Helm
- Docker containerization
- GitHub Actions CI/CD
- AWS ECR Image Registry
- AWS Load Balancer Controller
- Prometheus Monitoring
- Grafana Dashboards
- Loki Centralized Logging
- Terraform Remote State
- IAM Roles for Service Accounts (IRSA)

---

# Architecture

```
                    GitHub

                      │
               GitHub Actions

                      │

          Docker Build & Trivy Scan

                      │

             Push Image to ECR

                      │

             Helm Upgrade on EKS

                      │

      +-----------------------------+

      |        Amazon EKS           |

      |                             |

      |  AWS Load Balancer          |

      |          │                  |

      |      Kubernetes             |

      |      Deployment             |

      |          │                  |

      |      NodeJS Pods            |

      +-----------------------------+

               │          │

         Prometheus      Loki

               │          │

               ▼          ▼

             Grafana Dashboards
```

---

# 🛠️ Tech Stack

| Category | Technology |
|-----------|------------|
| Cloud | AWS |
| Kubernetes | Amazon EKS |
| IaC | Terraform |
| Container | Docker |
| Container Registry | Amazon ECR |
| CI/CD | GitHub Actions |
| Package Manager | Helm |
| Monitoring | Prometheus |
| Dashboard | Grafana |
| Logging | Loki + Promtail |
| Security Scan | Trivy |
| Load Balancer | AWS ALB Controller |
| Programming Language | Node.js |

---

# Repository Structure

```
project/

├── app/
│   ├── app.js
│   ├── package.json
│   ├── Dockerfile
│   └── test/
│
├── helm/
│   └── nodejs-app/
│
├── terraform/
│   ├── networking.tf
│   ├── eks.tf
│   ├── iam.tf
│   ├── iam-irsa.tf
│   ├── ecr.tf
│   ├── backend.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── versions.tf
│
├── terraform-bootstrap/
│   ├── main.tf
│   └── outputs.tf
│
├── monitoring/
│   ├── prometheus-values.yaml
│   ├── grafana-values.yaml
│   ├── loki-values.yaml
│   ├── promtail-values.yaml
│   └── alerts/
│
└── .github/
    └── workflows/
        └── ci-cd.yml
```

---

# Features Implemented

## Infrastructure

- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Amazon EKS Cluster
- Managed Node Group (Spot Instances)
- Amazon ECR
- IAM Roles
- IAM Policies
- OIDC Provider
- IRSA
- AWS Load Balancer Controller

---

## Kubernetes

- Helm Chart
- Deployment
- Service
- Ingress
- Configurable Values
- Rolling Updates
- Health Checks

---

## CI/CD

GitHub Actions pipeline performs:

- Source Checkout
- Node.js Setup
- Install Dependencies
- Unit Tests
- Docker Build
- Trivy Image Scan
- AWS OIDC Authentication
- Login to Amazon ECR
- Push Docker Image
- Update kubeconfig
- Helm Upgrade
- Deployment Verification
- Health Check

---

## Monitoring

Implemented using kube-prometheus-stack.

Includes:

- Prometheus
- Grafana
- AlertManager
- Node Exporter
- kube-state-metrics
- ServiceMonitor

Application metrics:

- HTTP Requests
- Error Count
- Request Duration
- Health Endpoint

---

## Logging

Implemented using:

- Loki
- Promtail
- Grafana Explore

Logs collected from Kubernetes Pods and visualized in Grafana.

---

## Security

- IAM Roles for Service Accounts (IRSA)
- GitHub OIDC Authentication
- Trivy Image Scanning
- Encrypted Terraform State
- Least Privilege IAM Policies
- Private Worker Nodes
- ALB Ingress

---

# Deployment Flow

```
Developer

↓

Git Push

↓

GitHub Actions

↓

Docker Build

↓

Trivy Scan

↓

Push to Amazon ECR

↓

Helm Upgrade

↓

Amazon EKS

↓

Rolling Update

↓

Application Available
```

---

# Observability

Metrics

- CPU Usage
- Memory Usage
- Pod Status
- Node Status
- Request Rate
- Error Rate
- Request Latency

Logging

- Centralized Log Collection
- Grafana Log Search
- Pod Logs
- Namespace Logs

Alerts

- High CPU
- High Memory
- Pod CrashLoopBackOff
- High Error Rate
- High Latency
- Target Down

---

# Cost Optimizations

Implemented:

- Spot Instances for Worker Nodes
- Single NAT Gateway
- t3.small EC2 Instances
- PAY_PER_REQUEST DynamoDB
- S3 Remote Backend
- Auto Scaling Node Group

---

# Terraform Remote State

Implemented using:

- Amazon S3 Backend
- Versioning Enabled
- Server Side Encryption
- DynamoDB State Locking

Benefits:

- Team Collaboration
- State Locking
- State Recovery
- Secure Remote Storage

---

# Future Improvements

The following features are planned for future enhancement:

- Amazon RDS PostgreSQL Integration
- AWS Secrets Manager
- External Secrets Operator
- Multi Environment Deployment
- ArgoCD GitOps
- Blue-Green Deployment
- Canary Deployment
- Multi Region Disaster Recovery
- Velero Backup
- Karpenter Auto Scaling
- Terraform Modules
- AWS WAF Integration

---

# Screenshots

Include screenshots for:

- GitHub Actions Pipeline
- EKS Cluster
- Node Group
- Amazon ECR
- ALB
- Kubernetes Pods
- Ingress
- Prometheus Targets
- Grafana Dashboard
- Loki Logs
- AlertManager
- Terraform Apply
- S3 Backend
- DynamoDB Lock Table

---

# Deployment

## Clone Repository

```bash
git clone https://github.com/<username>/<repository>.git

cd <repository>
```

---

## Bootstrap Backend

```bash
cd terraform-bootstrap

terraform init

terraform apply
```

---

## Deploy Infrastructure

```bash
cd terraform

terraform init

terraform apply
```

---

## Deploy Application

```bash
helm upgrade --install nodejs-app helm/nodejs-app
```

---

## Verify

```bash
kubectl get nodes

kubectl get pods

kubectl get svc

kubectl get ingress
```

---

# Learning Outcomes

This project demonstrates hands-on experience with:

- Infrastructure as Code
- Kubernetes
- Docker
- Helm
- AWS EKS
- GitHub Actions
- Terraform
- Prometheus
- Grafana
- Loki
- CI/CD
- DevSecOps
- Cloud Native Architecture

---

# Author

**Prashant Kumar**

Site Reliability Engineer | DevOps Engineer

AWS • Kubernetes • Terraform • Docker • CI/CD • Observability