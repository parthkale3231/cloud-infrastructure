# Production-Ready AWS Infrastructure using Terraform

## Project Overview

This project provisions a scalable and highly available AWS infrastructure using Terraform in the `us-east-1` region.

The infrastructure includes:

* Custom VPC
* Public and Private Subnets
* Internet Gateway
* Route Tables
* Security Groups
* EC2 Launch Template
* Auto Scaling Group
* Application Load Balancer (ALB)
* CloudWatch Monitoring
* SNS Notifications

The setup is optimized for:

* AWS Free Tier
* DevOps learning
* Resume projects
* Production-style deployment

---
 

User → Application Load Balancer → Auto Scaling Group → EC2 Instances

Features:

* Multi-AZ deployment
* Auto recovery
* Automatic scaling
* Monitoring and alerting
* Secure networking

---

# AWS Services Used

| Service                            | Purpose                   |
| ---------------------------------- | ------------------------- |
| Terraform                          | Infrastructure as Code    |
| Amazon Web Services                | Cloud Provider            |
| Amazon EC2                         | Compute Instances         |
| Elastic Load Balancing             | Application Load Balancer |
| Amazon CloudWatch                  | Monitoring                |
| Amazon SNS                         | Alerts and Notifications  |
| AWS Identity and Access Management | Permissions               |
| Amazon S3                          | Artifact Storage          |

---

# Features

## Networking

* Custom VPC
* Public Subnets
* Internet Gateway
* Route Tables
* Public Internet Access

## Security

* Security Groups
* SSH Access
* ALB Restricted Communication
* IAM Roles

## Compute

* Launch Templates
* Auto Scaling Group
* EC2 Bootstrap Automation

## Monitoring

* CloudWatch Metrics
* Health Checks
* Auto Recovery
* SNS Alerts

---

# Project Structure

```text
terraform-project/
│
├── provider.tf
├── variables.tf
├── vpc.tf
├── security-groups.tf
├── iam.tf
├── launch-template.tf
├── autoscaling.tf
├── alb.tf
├── cloudwatch.tf
├── outputs.tf
├── terraform.tfvars
└── userdata.sh
```

---

# Prerequisites

Before starting, install:

* Terraform
* AWS Command Line Interface
* AWS Account
* Git

---

# Configure AWS CLI

Configure AWS credentials:

```bash
aws configure
```

Provide:

* Access Key
* Secret Key
* Region → `us-east-1`
* Output Format → `json`

---

# Terraform Provider Configuration

## provider.tf

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

---

# Variables Configuration

## variables.tf

```hcl
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2" {
  default = "10.0.2.0/24"
}

variable "private_subnet_1" {
  default = "10.0.3.0/24"
}

variable "private_subnet_2" {
  default = "10.0.4.0/24"
}
```

---

# VPC and Networking

## Features

* Internet Gateway
* Public Route Table
* Route Table Associations
* Public IP Assignment

## Benefits

* Internet connectivity
* Public access to ALB and EC2
* Proper routing

---

# Security Groups

## ALB Security Group

Allows:

* HTTP traffic on port 80

## Application Security Group

Allows:

* Traffic from ALB on port 3000
* SSH access on port 22

---

# User Data Automation

The EC2 instances automatically:

* Install Python3
* Create application directory
* Generate sample web page
* Start HTTP server

---

# Launch Template

The Launch Template configures:

* Amazon Linux 2 AMI
* Free Tier instance type
* IAM instance profile
* User data bootstrap script
* Public IP assignment

---

# Auto Scaling Group

The Auto Scaling Group:

* Maintains healthy instances
* Replaces failed instances
* Distributes instances across AZs

## Configuration

| Setting          | Value    |
| ---------------- | -------- |
| Min Size         | 1        |
| Desired Capacity | 1        |
| Max Size         | 2        |
| Instance Type    | t2.micro |

---

# Application Load Balancer

The ALB:

* Receives internet traffic
* Performs health checks
* Routes traffic to healthy instances

Health Check Path:

```text
/
```

Target Port:

```text
3000
```

---

# CloudWatch Monitoring

CloudWatch monitors:

* ALB health
* Instance health
* HTTP 5XX errors
* Auto Scaling activity

---

# SNS Notifications

SNS sends alerts for:

* ALB failures
* Unhealthy instances
* Scaling events

---

# Deployment Steps

## Initialize Terraform

```bash
terraform init
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Preview Infrastructure

```bash
terraform plan
```

---

## Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

Terraform will provision:

* VPC
* Subnets
* Route Tables
* Internet Gateway
* Security Groups
* ALB
* Launch Template
* Auto Scaling Group
* CloudWatch Alarms

---

# Access the Application

After deployment:

```bash
terraform output
```

Copy the ALB DNS name and open in browser:

```text
http://ALB-DNS-NAME
```

Expected Output:

```html
AWS Terraform Project Working Successfully
```

---

# Troubleshooting

## 502 Bad Gateway

Cause:

* Application server not running

Fix:

* Check EC2 user data
* Verify Python server running
* Check Target Group health

---

## Target Group Unhealthy

Cause:

* Port 3000 blocked
* App crashed
* User data failed

Fix:

* Verify Security Groups
* Verify EC2 connectivity
* Check `/var/log/cloud-init-output.log`

---

## EC2 Instance Connect Failure

Cause:

* SSH port 22 blocked
* No public route

Fix:

* Add SSH ingress rule
* Associate Route Table
* Enable Public IP assignment

---

# Free Tier Optimizations

This project uses:

* `t2.micro`
* Minimal Auto Scaling capacity
* Lightweight Python HTTP server

This helps reduce AWS charges.

---

# Security Best Practices

* Use IAM Roles instead of credentials
* Restrict inbound traffic
* Use Security Groups properly
* Enable monitoring and logging
* Use private networking in production

---

# Recommended Improvements

Future enhancements:

* HTTPS with ACM
* Route53 custom domain
* Docker containers
* GitHub Actions CI/CD
* Terraform remote backend
* ECS or Kubernetes
* RDS integration
* WAF security

---

# Destroy Infrastructure

To avoid AWS charges:

```bash
terraform destroy
```

---

# Learning Outcomes

By completing this project, you learn:

* Terraform fundamentals
* AWS networking
* Infrastructure as Code
* Auto Scaling
* Load Balancing
* Cloud Monitoring
* DevOps workflows
* Production deployment concepts

---

# Resume Project Title

## Production-Ready AWS Infrastructure using Terraform

### Skills Demonstrated

* Terraform
* AWS
* DevOps
* Infrastructure Automation
* Auto Scaling
* Load Balancing
* Cloud Monitoring
* High Availability
