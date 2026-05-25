# EC2 Auto Scaling Project using Terraform (AWS Free Tier)

## Project Overview

This project demonstrates how to build and manage an AWS EC2 Auto Scaling infrastructure using Terraform as Infrastructure as Code (IaC). The setup is optimized for AWS Free Tier and deployed in the `us-east-1` region.

The infrastructure automatically launches EC2 instances, scales them dynamically based on load, and performs rolling updates with minimal downtime.

---

# Features Implemented

* Terraform-based Infrastructure as Code
* Custom VPC Creation
* Public Subnets Across Multiple AZs
* Internet Gateway & Route Tables
* Security Groups
* EC2 Launch Template
* Auto Scaling Group (ASG)
* Scheduled Scaling
* Step Scaling
* Target Tracking Scaling
* CloudWatch Monitoring
* Instance Refresh
* Apache Web Server Deployment
* Public IP Auto Assignment
* Free Tier Optimized

---

# AWS Services Used

| Service            | Purpose                       |
| ------------------ | ----------------------------- |
| Amazon EC2         | Virtual servers               |
| Auto Scaling Group | Automatic instance scaling    |
| Launch Template    | Instance configuration        |
| CloudWatch         | Monitoring and scaling alarms |
| VPC                | Networking                    |
| Internet Gateway   | Internet access               |
| Security Groups    | Firewall configuration        |
| Terraform          | Infrastructure automation     |

---

# Architecture

The architecture includes:

* Custom VPC
* Two Public Subnets
* Internet Gateway
* Route Tables
* Auto Scaling Group
* Launch Template
* EC2 Instances
* CloudWatch Monitoring

Instances are automatically launched in multiple Availability Zones for high availability.

---

# Project Structure

```text id="xq4n2j"
terraform-autoscaling/
│
├── provider.tf
├── variables.tf
├── vpc.tf
├── security-group.tf
├── launch-template.tf
├── autoscaling.tf
├── scaling-policies.tf
├── outputs.tf
├── terraform.tfvars
└── README.md
```

---

# Region

* AWS Region: `us-east-1`

---

# Free Tier Configuration

| Resource         | Configuration  |
| ---------------- | -------------- |
| Instance Type    | t2.micro       |
| Desired Capacity | 1              |
| Minimum Capacity | 1              |
| Maximum Capacity | 2              |
| Operating System | Amazon Linux 2 |

---

# Networking Configuration

The project provisions:

* Custom VPC
* Public Subnet 1 (`us-east-1a`)
* Public Subnet 2 (`us-east-1b`)
* Internet Gateway
* Public Route Table

All EC2 instances launched by the Auto Scaling Group receive public internet access.

---

# Security Group Rules

## Inbound Rules

| Port | Protocol | Purpose         |
| ---- | -------- | --------------- |
| 22   | TCP      | SSH Access      |
| 80   | TCP      | HTTP Web Access |

## Outbound Rules

* Allow all outbound traffic

---

# Launch Template

The Launch Template defines:

* Amazon Linux 2 AMI
* t2.micro Instance Type
* Public IP Association
* Security Groups
* User Data Script

The User Data script automatically:

* Installs Apache HTTP Server
* Starts the service
* Enables Apache on boot
* Creates a sample web page

---

# Auto Scaling Group

The Auto Scaling Group:

* Maintains desired capacity
* Automatically replaces unhealthy instances
* Launches instances across multiple AZs
* Supports rolling instance refresh

## ASG Configuration

| Parameter        | Value |
| ---------------- | ----- |
| Desired Capacity | 1     |
| Minimum Size     | 1     |
| Maximum Size     | 2     |

---

# Scaling Policies

## 1. Scheduled Scaling

Automatically increases or decreases capacity based on time schedules.

### Example

* Scale up during business hours
* Scale down during off-hours

---

## 2. Step Scaling

Scales instances depending on CPU utilization severity.

### Example

| CPU Usage | Action         |
| --------- | -------------- |
| >70%      | Add 1 Instance |

---

## 3. Target Tracking Scaling

Maintains a target CPU utilization automatically.

### Target

* 50% Average CPU Utilization

AWS automatically adjusts instance count.

---

# CloudWatch Monitoring

CloudWatch monitors:

* CPU utilization
* Scaling activities
* EC2 instance metrics
* Alarm states

---

# Instance Refresh

Instance Refresh provides:

* Rolling deployments
* Zero downtime updates
* Safe launch template upgrades

Used when:

* Updating AMI
* Changing configuration
* Deploying application updates

---

# Deployment Workflow

## Step 1 – Initialize Terraform

Terraform initializes providers and modules.

---

## Step 2 – Validate Configuration

Checks Terraform syntax and configuration validity.

---

## Step 3 – Plan Infrastructure

Displays infrastructure changes before deployment.

---

## Step 4 – Apply Infrastructure

Creates AWS infrastructure resources.

---

## Step 5 – Access Web Application

After deployment:

1. Open AWS EC2 Console
2. Copy the Public IPv4 Address
3. Open it in the browser

Expected Output:

```text id="nl5v6r"
Hello from Terraform Auto Scaling Project
```

---

# How to Verify Auto Scaling

## EC2 Console

Navigate to:

* EC2 → Auto Scaling Groups

You can monitor:

* Desired capacity
* Current instances
* Scaling activities
* Health checks

---

# How to Test Scaling

Generate CPU load on the EC2 instance and monitor:

* CloudWatch alarms
* ASG activity
* Instance creation

New instances will launch automatically when CPU threshold is crossed.

---

# Common Issues & Fixes

## Website Not Opening

### Possible Causes

* Port 80 blocked
* Apache not running
* Public IP missing
* Internet Gateway missing

### Fixes

* Verify Security Group rules
* Ensure Apache service is running
* Confirm public subnet configuration
* Verify public IP association

---

# Cost Optimization Tips

## Recommended Settings

| Setting          | Recommended         |
| ---------------- | ------------------- |
| Instance Type    | t2.micro            |
| Desired Capacity | 1                   |
| Maximum Capacity | 2                   |
| Warm Pools       | Avoid for Free Tier |

---

# Learning Outcomes

After completing this project, you will understand:

* Terraform basics
* Infrastructure as Code
* AWS Auto Scaling
* CloudWatch monitoring
* Scaling strategies
* Rolling deployments
* Cloud networking
* Free Tier optimization

---

# Resume Skills Demonstrated

* Terraform
* AWS EC2
* Auto Scaling
* Infrastructure Automation
* Cloud Networking
* Monitoring & Scaling
* DevOps Practices

---

# Clean Up

Destroy infrastructure after testing to avoid AWS charges.

Terraform will remove:

* EC2 Instances
* Auto Scaling Group
* VPC Resources
* Security Groups
* CloudWatch Resources

---

# Conclusion

This project demonstrates a production-style AWS Auto Scaling infrastructure using Terraform while remaining within Free Tier limits. It provides hands-on experience with cloud automation, dynamic scaling, monitoring, and high-availability infrastructure design.

This project is highly suitable for:

* DevOps learning
* AWS practice
* Resume projects
* Cloud engineering interviews

---

# Architecture Reference

![Image](https://images.openai.com/static-rsc-4/UpWI-H89LSobg5XNnjbjxXyFe0MYp-nlDiYFMjobyrEDPZOXfqYj5Yv2TCX4_6eMRn5Os2RDf90boQjKbn-JQLCIq18qv6p71DxPIMDAjvijS1b_-LmAyyExh21e1s84PAtngWw4a0wilgRUzixuYUvmk84bdtMf-ByIVZDHm9Vu83iNIhpGI4T3btVEeFvr?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/aQVK-IR2Icszcbk9D1nchxsDSrZ5-9JdbCZAQBMzqqgPNZfrihHSmBtnjxg9SpGGdP03nMVLy0AzWiz8bPD6RFjPbmpcnxmuBX59BWxuFXXaut3OETzHElImrIFZFTA43d4oWkKqRaD9Onrcy3YIprSbVIHJha8tzUzo3aUs30T3Xt9NSxxjbcPL4yFMCYBI?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/wU0oqFnBy5z6t1ZHR-WyD1StkNjKu6SHn5XaZTk_GLKiLvcCQipcDA751wQ0tCJFw2bZWcgabCLyYe5LJjtkSK6r_DZJBgjizHE4d6rckInbj_y-x0zVw8VOZF2xfO8xXsaXlRmDXwaSV5HwtzNxdW8buZdSsU1t6Z0G57S3HToDRJ1m828Crr9wmTbcgCSv?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/s7LjyWHBj95qqbMUWmDl0wAwUIAOVmyuQTKOhoP3EpxPyWTfA8kRnlu-rQ2eSvyF9xsij6xAlTR-j0zIF4YujXz8RgyEru2g6gr6kaOz0ZNFiLybrR488yWDuLdGaDxrB8sEm4x_49KO7MbhkUxDmWfEUmBY7rF5s3HBIRfP8Cl7PTGvskBjeJ6obHa_8yUI?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/bS5zhpDausbQ4KsM5CPYD5dLqaEvBSKKGpREzpkT8IslzmiQjY3d7dmxtFtW_7QbjPGrmhk-I-jrd8UAnApA0uN9HVkpCILvR_v5SB6vMQSypAgshA60yJLd1UR6JcImkZPqLAKSrkWwZm6qQ9bcSKmQGNDohwUGTxhgZblyckckMg2NK_MRNgT8ImNxcvjq?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/kCnhX_dQqAkNvt3gKB_pyp5EA2B3thf8C4G7hxzriGXCm92syIVMBhIJxirVc0Qv0E9lAber7T6RK4Do9uZ4byn6D9D6-vCmrHkozUwat0xTdqA2LtDOZp6gqvhxZvpUWEQ90Dh9N94l3ir5ASmwrW3oVuD-usA6DnsbNHQyLZonL-W8OAsfzI_Smoyk05oy?purpose=fullsize)
