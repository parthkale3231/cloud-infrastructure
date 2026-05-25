# AWS Multi-Tier Architecture using Terraform

## Project Overview

This project demonstrates how to build a complete **Production-Style Multi-Tier Architecture on AWS using Terraform**.

The infrastructure is fully automated using Infrastructure as Code (IaC), where Terraform provisions networking, compute, security, database, caching, and storage resources inside AWS.

The architecture follows modern cloud engineering and DevOps best practices used in enterprise environments.

---

# Architecture Diagram

```text id="a1k7pl"
                    Internet Users
                           │
                           ▼
              Application Load Balancer
                     (Public Subnets)
                           │
                           ▼
                 Application Servers
                 (Private App Subnets)
                           │
          ┌────────────────┴───────────────┐
          ▼                                ▼
      Redis Cache                    PostgreSQL RDS
   (Private Cache)                 (Private DB Subnets)
          │
          ▼
      Amazon S3
   (via VPC Endpoint)
```

---

# Technologies Used

| Technology        | Purpose                 |
| ----------------- | ----------------------- |
| Terraform         | Infrastructure as Code  |
| AWS VPC           | Private Networking      |
| EC2               | Application Servers     |
| ALB               | Load Balancing          |
| RDS PostgreSQL    | Relational Database     |
| Redis ElastiCache | Caching Layer           |
| S3                | Object Storage          |
| IAM               | Access Control          |
| NAT Gateway       | Private Internet Access |
| Security Groups   | Firewall Rules          |

---

# Features Implemented

## Networking

* Custom VPC
* Public and Private Subnets
* Multi-AZ Architecture
* Internet Gateway
* NAT Gateway
* Route Tables

---

## Security

* Tier-based Security Groups
* Private Database Isolation
* Least Privilege Networking
* Internal Application Communication

---

## Application Layer

* EC2 Auto Scaling Group
* Private Application Servers
* Load Balanced Traffic

---

## Database Layer

* PostgreSQL RDS
* DB Subnet Groups
* Encrypted Storage
* Private Database Access

---

## Cache Layer

* Redis ElastiCache
* In-Memory Caching
* Faster Application Performance

---

## Storage Layer

* Amazon S3 Bucket
* VPC Endpoint Integration
* Secure Internal AWS Communication

---

# Project Structure

```text id="6g6v8l"
multi-tier-terraform/
│
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
│
├── vpc.tf
├── security-groups.tf
├── alb.tf
├── ec2.tf
├── rds.tf
├── redis.tf
├── s3.tf
├── vpce.tf
├── iam.tf
│
└── userdata.sh
```

---

# Infrastructure Components

# 1. VPC

The VPC acts as the private isolated network.

## CIDR Block

```text id="8r9px8"
10.0.0.0/16
```

---

# 2. Public Subnets

Used for:

* Application Load Balancer
* NAT Gateway

## Public Subnet CIDRs

```text id="gxaqkt"
10.0.1.0/24
10.0.2.0/24
```

---

# 3. Private Application Subnets

Used for:

* EC2 Application Servers

## App Subnet CIDRs

```text id="nvhgm5"
10.0.11.0/24
10.0.12.0/24
```

---

# 4. Private Database Subnets

Used for:

* PostgreSQL RDS

## DB Subnet CIDRs

```text id="uzldki"
10.0.21.0/24
10.0.22.0/24
```

---

# 5. Private Cache Subnets

Used for:

* Redis ElastiCache

## Cache Subnet CIDRs

```text id="d2g5xe"
10.0.31.0/24
10.0.32.0/24
```

---

# 6. Internet Gateway

Provides internet access to public subnets.

---

# 7. NAT Gateway

Allows private resources to access the internet outbound only.

Used for:

* Package downloads
* OS updates
* Docker image pulls

---

# 8. Route Tables

## Public Route Table

Routes traffic to:

```text id="jlwmij"
Internet Gateway
```

## Private Route Table

Routes traffic to:

```text id="bsby1h"
NAT Gateway
```

---

# 9. Application Load Balancer

The ALB distributes incoming user traffic.

## Responsibilities

* HTTPS termination
* Load balancing
* Health checks
* Traffic routing

---

# 10. EC2 Auto Scaling Group

Provides scalable application infrastructure.

## Features

* Automatic scaling
* Fault tolerance
* Multi-AZ deployment

---

# 11. PostgreSQL RDS

Managed relational database service.

## Features

* Automated management
* Encrypted storage
* Private networking
* Secure DB access

---

# 12. Redis ElastiCache

Provides high-speed in-memory caching.

## Benefits

* Faster responses
* Reduced DB load
* Improved scalability

---

# 13. S3 Bucket

Used for:

* File storage
* Logs
* Backups
* Static assets

---

# 14. VPC Endpoint

Provides private communication between VPC and S3.

---

# Security Architecture

## Security Groups

| Source      | Destination | Port   |
| ----------- | ----------- | ------ |
| Internet    | ALB         | 80/443 |
| ALB         | App Servers | 8080   |
| App Servers | Redis       | 6379   |
| App Servers | PostgreSQL  | 5432   |

---

# Terraform Workflow

# Step 1 — Initialize Terraform

Terraform downloads required providers and initializes the project.

---

# Step 2 — Validate Configuration

Checks Terraform syntax and resource references.

---

# Step 3 — Plan Infrastructure

Shows resources Terraform will create.

---

# Step 4 — Apply Infrastructure

Creates AWS resources automatically.

---

# Step 5 — Destroy Infrastructure

Removes all infrastructure resources.

---

# Expected AWS Resources Created

After deployment, AWS will contain:

## Networking

* 1 VPC
* 6 Subnets
* 1 Internet Gateway
* 1 NAT Gateway
* Route Tables

---

## Security

* ALB Security Group
* App Security Group
* Database Security Group
* Redis Security Group

---

## Compute

* EC2 Launch Template
* Auto Scaling Group

---

## Database

* PostgreSQL RDS
* DB Subnet Group

---

## Cache

* Redis Replication Group

---

## Storage

* S3 Bucket
* VPC Endpoint

---

# Outputs

Terraform outputs:

* ALB DNS Name
* RDS Endpoint
* Redis Endpoint

---

# Architecture Flow

```text id="4x8g6x"
Users
   ↓
ALB
   ↓
EC2 Application Servers
   ↓
Redis Cache
   ↓
PostgreSQL Database
```

---

# High Availability

The architecture uses multiple Availability Zones.

## Benefits

* Fault tolerance
* Reduced downtime
* Improved reliability

---

# Best Practices Implemented

* Private subnet isolation
* Infrastructure as Code
* Least privilege access
* Separate security groups
* NAT Gateway for private internet access
* Encrypted database storage
* Scalable infrastructure
* Modular cloud design

---

# Free Tier Notes

For Free Tier compatibility:

* Use `db.t3.micro`
* Disable Multi-AZ
* Use small storage sizes
* Set backup retention to 0

---

# Real-World Use Cases

This architecture is suitable for:

* SaaS applications
* E-commerce platforms
* Banking systems
* Enterprise APIs
* Educational platforms
* AI/ML applications
* Microservices platforms

---

# Learning Outcomes

By building this project, you learn:

* AWS Networking
* Terraform IaC
* Cloud Security
* Multi-Tier Architecture
* DevOps Practices
* Auto Scaling
* Database Management
* Load Balancing
* Cloud Infrastructure Automation

---

# Future Enhancements

Possible improvements:

* HTTPS with ACM
* AWS WAF
* ECS/EKS Deployment
* CI/CD Pipelines
* Kubernetes
* CloudFront CDN
* Monitoring Dashboards
* Terraform Modules
* Blue-Green Deployment

---

# Conclusion

This project demonstrates a complete AWS production-style multi-tier cloud architecture automated using Terraform.

The infrastructure follows modern DevOps and cloud-native practices including:

* Security isolation
* Scalability
* High availability
* Infrastructure automation
* Private networking
* Managed cloud services

It serves as an excellent real-world DevOps and Cloud Engineering project for learning, portfolio building, and production deployment scenarios.
