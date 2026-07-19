                    Internet
                        │
                Internet Gateway
                        │
                Public Route Table
                        │
      ┌─────────────────┴─────────────────┐
      │                                   │
Public Subnet A                    Public Subnet B
10.0.1.0/24                        10.0.2.0/24
      │
      │
  NAT Gateway
      │
      │
Private Route Table
      │
 ┌────┴──────────────┐
 │                   │
Private Subnet A   Private Subnet B
10.0.11.0/24       10.0.12.0/24
 │                   │
 │                   │
EKS Nodes          RDS
Pods               Redis
RabbitMQ           Prometheus


                    AWS

                     │

        ┌────────────┴────────────┐

        │                         │

 EKS Cluster Role          Node Group Role

        │                         │

 Control Plane             EC2 Worker Nodes

                     AWS

                     │

          EKS Control Plane
            (Managed by AWS)
                     │
     IAM Role: eks-cluster-role
                     │
          Schedules Pods
                     │
      --------------------------
      │                        │
      ▼                        ▼
 EC2 Worker Node 1      EC2 Worker Node 2
      │                        │
      └──────────────┬─────────┘
                     │
          IAM Role: eks-node-role
                     │
                     ▼
        ECR, CloudWatch, CNI, EBS




                 Terraform

                     │

                     ▼

             AWS EKS Service API

                     │

         Creates Control Plane

                     │

     -------------------------------

     API Server

     Scheduler

     Controller Manager

     ETCD

     -------------------------------

                     │

           Waits until ACTIVE

                     │

                     ▼

        Managed Node Group (EC2)

                     │

             EC2 Boots

                     │

          kubelet starts

                     │

          Uses IAM Role

                     │

          Registers to API Server

                     │

                     ▼

kubectl get nodes




                   AWS

        -----------------------

           EKS Control Plane

        (AWS Managed Service)

        -----------------------

                 ||

          Kubernetes API

                 ||

========================================

            Your VPC

========================================

Private Subnet A

EC2 Worker

Pods

========================================

Private Subnet B

EC2 Worker

Pods