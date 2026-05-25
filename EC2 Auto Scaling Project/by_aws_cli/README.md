# EC2 Auto Scaling Project – AWS Free Tier (us-east-1)

## Overview

This project demonstrates how to configure and manage Amazon EC2 Auto Scaling using different scaling policy types in AWS. The implementation is designed specifically for the AWS Free Tier using the `t2.micro` instance type in the `us-east-1` region.

The project covers:

* Manual Scaling
* Scheduled Scaling
* Simple Scaling
* Step Scaling
* Target Tracking Scaling
* Predictive Scaling
* Instance Refresh
* Warm Pools

The goal of this project is to understand how Auto Scaling automatically adjusts infrastructure capacity based on workload demand while maintaining high availability and cost optimization.

---

# Architecture

The architecture consists of:

* EC2 Launch Template
* Auto Scaling Group (ASG)
* Security Group
* CloudWatch Metrics and Alarms
* Scaling Policies
* Optional Warm Pool
* Optional Predictive Scaling

Instances are distributed across multiple subnets for better availability and fault tolerance.

---

# AWS Services Used

| Service            | Purpose                      |
| ------------------ | ---------------------------- |
| Amazon EC2         | Virtual servers              |
| Auto Scaling Group | Automatic scaling management |
| Launch Template    | Instance configuration       |
| Amazon CloudWatch  | Monitoring and alarms        |
| IAM                | Permissions                  |
| VPC                | Networking                   |
| Security Groups    | Firewall rules               |

---

# Region

This project uses:

* **AWS Region:** `us-east-1`

This region is preferred because:

* It supports Free Tier resources
* Lower service limitations
* Broadest feature availability

---

# Free Tier Configuration

| Resource           | Configuration      |
| ------------------ | ------------------ |
| Instance Type      | t2.micro           |
| Minimum Capacity   | 1                  |
| Desired Capacity   | 1                  |
| Maximum Capacity   | 2                  |
| Operating System   | Amazon Linux 2     |
| Scaling Policies   | Free Tier Safe     |
| Predictive Scaling | Forecast Only Mode |

---

# Project Components

## 1. Launch Template

The Launch Template defines:

* AMI
* Instance type
* Security groups
* User data scripts
* Storage configuration

It acts as a reusable configuration blueprint for EC2 instances launched by the Auto Scaling Group.

---

## 2. Auto Scaling Group

The Auto Scaling Group:

* Maintains desired instance count
* Replaces unhealthy instances automatically
* Scales instances up or down
* Distributes instances across subnets

### Configuration

* Minimum Instances: 1
* Desired Instances: 1
* Maximum Instances: 2

This setup keeps the project within Free Tier limits.

---

# Scaling Policies

## 3. Manual Scaling

Manual scaling allows administrators to directly change the desired number of instances.

### Use Cases

* Maintenance activities
* Load testing
* Temporary scaling needs
* Troubleshooting

### Advantages

* Simple to manage
* Full control over scaling

### Limitations

* No automation
* Requires manual intervention

---

## 4. Scheduled Scaling

Scheduled scaling automatically adjusts capacity based on predefined schedules.

### Example Scenarios

* Scale up during business hours
* Scale down during nighttime
* Weekend traffic management

### Advantages

* Predictable scaling
* Cost optimization
* Ideal for known traffic patterns

### Free Tier Recommendation

Keep scaling between 1 and 2 instances only.

---

## 5. Simple Scaling

Simple scaling increases or decreases instances when a CloudWatch alarm is triggered.

### Features

* Uses cooldown periods
* Easy to configure
* Basic automation

### Example Trigger

* CPU utilization above 70%

### Limitations

* Slower response due to cooldowns

---

## 6. Step Scaling

Step scaling adjusts capacity based on the severity of metric breaches.

### Example

* CPU > 70% → Add 1 instance
* CPU > 85% → Add 2 instances

### Advantages

* Faster than simple scaling
* More flexible
* Better workload handling

### Recommended For

Applications with sudden traffic spikes.

---

## 7. Target Tracking Scaling

Target tracking automatically maintains a target metric value.

### Example

Maintain:

* CPU Utilization at 50%

AWS automatically:

* Adds instances when CPU increases
* Removes instances when CPU decreases

### Advantages

* Fully automated
* Simplest dynamic scaling method
* Recommended for production workloads

---

## 8. Predictive Scaling

Predictive scaling uses machine learning to forecast future traffic patterns.

### Features

* Forecasts future demand
* Proactively scales infrastructure
* Reduces latency during spikes

### Free Tier Recommendation

Use:

* Forecast Only Mode

Avoid:

* Automatic scaling mode for Free Tier accounts

### Benefits

* Better performance planning
* Reduced scaling delays

---

# Instance Refresh

Instance Refresh performs rolling updates for EC2 instances without downtime.

### Use Cases

* Updating AMIs
* Security patching
* Configuration changes
* Application deployments

### Features

* Rolling replacement
* Health checks
* Controlled deployment
* Zero-downtime updates

### Workflow

1. Create new launch template version
2. Start instance refresh
3. ASG replaces instances gradually

---

# Warm Pools

Warm Pools maintain pre-initialized EC2 instances ready for immediate use.

### Benefits

* Faster scaling response
* Reduced startup latency
* Better user experience during traffic spikes

### Limitations

* Additional EBS storage charges may apply

### Free Tier Note

Use cautiously to avoid unnecessary charges.

---

# Monitoring

Amazon CloudWatch is used for:

* CPU utilization monitoring
* Scaling triggers
* Alarm creation
* Performance analysis

### Important Metrics

* CPUUtilization
* NetworkIn
* NetworkOut
* StatusCheckFailed

---

# Security

Security best practices used in this project:

* Security groups allowing only required ports
* Least privilege IAM permissions
* Multi-subnet deployment
* Health checks enabled

---

# Cost Optimization Tips

## Recommended Practices

### Use Free Tier Resources

* Use only `t2.micro` instances
* Keep ASG size small

### Limit Maximum Capacity

* Recommended max size: 2

### Avoid Large Warm Pools

* Warm pools may incur storage charges

### Use Scheduled Scaling

* Scale down during off-hours

### Use Spot Instances (Advanced)

Combine:

* On-Demand base capacity
* Spot instances for extra capacity

Potential savings:

* 60–70% EC2 cost reduction

---

# Learning Outcomes

After completing this project, you will understand:

* EC2 Auto Scaling fundamentals
* Dynamic infrastructure scaling
* CloudWatch monitoring
* Scaling strategies
* Cost optimization techniques
* Zero-downtime deployments
* Predictive infrastructure management

---

# Best Scaling Policy Comparison

| Policy Type        | Automation Level | Response Speed | Best Use Case            |
| ------------------ | ---------------- | -------------- | ------------------------ |
| Manual Scaling     | Low              | Manual         | Testing                  |
| Scheduled Scaling  | Medium           | Scheduled      | Predictable traffic      |
| Simple Scaling     | Medium           | Moderate       | Basic automation         |
| Step Scaling       | High             | Fast           | Sudden spikes            |
| Target Tracking    | High             | Automatic      | General production       |
| Predictive Scaling | Very High        | Proactive      | Forecast-based workloads |

---

# Conclusion

This project provides hands-on experience with AWS EC2 Auto Scaling using multiple scaling techniques while staying within AWS Free Tier limits. It demonstrates how cloud infrastructure can automatically adapt to workload changes, improve application availability, and optimize operational costs.

The project is ideal for:

* DevOps beginners
* Cloud engineering practice
* AWS learning
* Resume projects
* Interview preparation

---

# Architecture Reference

![Image](https://images.openai.com/static-rsc-4/8laggJXSU8HOELOHhDli_Oz_C7tO6S4PjtxLyo2DLJiS8ZnwkF0coElsOG6yIf5meJibX0ieEEYI3MFocnvsp5BEyMPl2LrDrneyY0Slvy4zu9KhajcKOcJIrpDGuMlBjqV4ErIJvyI0faeNRYT6dzM7dgQMVF-xD3MK9LX-wDn9pWueMIssoKdPiqcV_2CE?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/kCnhX_dQqAkNvt3gKB_pyp5EA2B3thf8C4G7hxzriGXCm92syIVMBhIJxirVc0Qv0E9lAber7T6RK4Do9uZ4byn6D9D6-vCmrHkozUwat0xTdqA2LtDOZp6gqvhxZvpUWEQ90Dh9N94l3ir5ASmwrW3oVuD-usA6DnsbNHQyLZonL-W8OAsfzI_Smoyk05oy?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/9Mm427pKkGMSHWe_jCEpDQc2KX_o4wsYeJDexS8qhTyb9CouusFwPZGyJmvvcYwuqVrLjmFLZBwivAgsoV11R7MUGmhipcMp2kLeWn5ZGDqdJgV3vpiuQGYBdkHyE32lT949reXWDMf5MQgmlf-LlnlhGUJguZRIEeRrPhrx9HAgfqyt2Ja6KoZJwhnwxZ0Z?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/_wMzH-d52Gr25d-xeeQJOhNYbWaQ5WXblqwuKAQIi5NvqiAgbqX7-F2G67SBIZtQj3s-mEEUVu894SYVKUCO31NKJ5WJTRImAMfGCBVyhDyAOqt_JIoQF6PqXXfdtJaMl2SE4JMLK41li_Ty3i_65ML48PNEbC0t-jVZsaWvmMnGLvxnM-SrMU7k8oPJaGuz?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/1ctR2GURuHgT0Ngp4JbfEFxg882VqGxvpn_Ok49RtP8J0bG0XLkI7pU5G3-xP3wHfVGknF3HTpAQQo9MUsfRp9LfL4kKOW0MfCPfIsffCH-eqW9kk1j7ecuqHljThG94u75B2XCoN5s5q4EC9ja0kdOX9Ik9pKeHCOU8wws4nHWTOjJ54VhnsB0bq25uasfw?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/W9Cf29neqF2jel9PyrzZfKwnwZ1TKgimMuLaAIITMVUpCVlDxpNve3Z1erPPxSmxnNG30wC9sa_jb3C04U06YM0PH4To6rCew8tu0y8xTdAacOO2QT1Qv5Bl4IGJ3mlngT2XLzEVREtod8dTJwUGUSm6xEP1ZQojq6Ps5GY_-Ikcx8xCLPBgFrN_tfNRPE7g?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/aeB12vRlENVK7K5MS_P8sZdGPwnK-O0WTQDR9BFBUTGtkNZZUaHsXc11Lg9JhxL0Yl_au3IchC54_ID32l8wdpa96qWzaxaCW1bFinc8vYqrlwghRHu-ldTpQAxv2Ne8GClg7GAvHfLe22MQpbObH0-L-bVfItxlM6oqeqEc_8r58ixJoqX56rEDFoCtHjAc?purpose=fullsize)
