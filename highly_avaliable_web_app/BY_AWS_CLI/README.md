# Auto Scaling and CloudWatch Monitoring Setup on AWS

## Overview

This project configures a highly available and scalable application infrastructure on AWS using:

* Auto Scaling Groups (ASG)
* Launch Templates
* Application Load Balancer (ALB)
* CloudWatch Monitoring and Alarms
* SNS Alert Notifications

The setup is designed for:

* High availability
* Automatic scaling based on CPU usage
* Health monitoring
* Alerting on failures
* Production-ready infrastructure practices

The deployment is configured in the **US East (N. Virginia)** region (`us-east-1`) and optimized for AWS Free Tier wherever possible.

---

# Architecture

The infrastructure includes:

* EC2 instances running a Node.js application
* Launch Template for reusable EC2 configuration
* Auto Scaling Group for automatic instance management
* Application Load Balancer for traffic distribution
* CloudWatch alarms for monitoring
* SNS notifications for alerts

Traffic Flow:

User → ALB → Auto Scaling Group → EC2 Instances

---

# Components Used

## 1. Launch Template

The Launch Template defines:

* Amazon Linux 2 AMI
* EC2 instance type
* Security Groups
* IAM instance profile
* User data bootstrap script

### User Data Responsibilities

The EC2 bootstrap process automatically:

* Updates system packages
* Installs Node.js and AWS CLI
* Downloads application artifacts from S3
* Extracts application files
* Installs dependencies
* Retrieves configuration from AWS Systems Manager Parameter Store
* Starts the Node.js server

---

# 2. Auto Scaling Group (ASG)

The Auto Scaling Group ensures:

* Desired number of instances are always running
* Failed instances are automatically replaced
* Application scales during traffic spikes

### Features Configured

* Multi-AZ deployment
* Health checks through Load Balancer
* Automatic instance replacement
* Scaling policies
* Controlled termination policies

### Scaling Configuration

* Minimum capacity: 1 instance
* Desired capacity: 1 instance
* Maximum capacity: 2 instances

This configuration helps remain within AWS Free Tier limits.

---

# 3. Scaling Policies

## Step Scaling Policy

This policy increases the number of EC2 instances when CPU usage rises.

### Behavior

* Small increase in CPU → add 1 instance
* Large increase in CPU → add 2 instances

This provides responsive scaling during load spikes.

---

## Target Tracking Scaling Policy

This policy maintains average CPU utilization around 60%.

### Advantages

* Fully automatic scaling
* Easier to manage
* AWS recommended approach
* Helps optimize performance and cost

---

# 4. Application Load Balancer (ALB)

The ALB distributes incoming traffic across multiple EC2 instances.

### Benefits

* High availability
* Fault tolerance
* Health-based routing
* Better performance

### Health Checks

The load balancer continuously verifies:

* Application availability
* Healthy backend instances

Unhealthy instances stop receiving traffic automatically.

---

# 5. CloudWatch Monitoring

Amazon CloudWatch is used for:

* Infrastructure monitoring
* Application health tracking
* Alert generation

---

# 6. CloudWatch Alarms

## ALB 5XX Error Alarm

This alarm triggers when:

* Backend servers generate too many 5XX errors

### Purpose

* Detect application failures
* Identify crashing services
* Detect backend instability

### Condition

* More than 10 server-side errors within 5 minutes

---

## Auto Scaling Health Alarm

This alarm triggers when:

* Healthy instances drop below the required threshold

### Purpose

* Detect instance failures
* Detect scaling issues
* Ensure application availability

### Condition

* Less than 2 healthy instances for 2 consecutive checks

---

# 7. SNS Notifications

Amazon SNS is used to send alerts when alarms trigger.

### Supported Notification Methods

* Email
* SMS
* Lambda
* Slack integrations

### Recommended Setup

* Create a production alerts topic
* Subscribe DevOps/admin email addresses
* Confirm subscriptions

---

# Security Best Practices

## IAM Roles

EC2 instances should have only required permissions:

* Read access to S3 artifacts
* Access to SSM Parameter Store
* CloudWatch logging permissions

---

## Private Subnets

Application instances should run in private subnets for better security.

---

## Security Groups

Restrict access:

* Allow ALB access only to application ports
* Allow SSH only from trusted IPs
* Restrict database access

---

# High Availability Features

The setup provides:

* Multi-AZ deployment
* Automatic recovery
* Health-based traffic routing
* Dynamic scaling
* Failure alerting

This ensures the application remains available even during:

* EC2 instance failures
* Increased traffic
* AZ-level issues

---

# Monitoring Recommendations

Additional recommended alarms:

* High CPU usage
* High memory utilization
* Low disk space
* ALB latency
* Request count spikes

---

# Cost Optimization

To remain Free Tier friendly:

* Use `t2.micro`
* Keep minimum ASG size low
* Monitor unused resources
* Remove unused EBS volumes
* Use lifecycle policies for S3

---

# AWS Services Used

* Amazon EC2
* Auto Scaling
* Application Load Balancer
* Amazon CloudWatch
* Amazon SNS
* AWS Systems Manager Parameter Store
* Amazon S3
* IAM

---

# Outcome

After deployment:

* The application automatically scales
* Traffic is load balanced
* Failed instances recover automatically
* Alerts are generated during failures
* Infrastructure becomes production-ready and highly available
