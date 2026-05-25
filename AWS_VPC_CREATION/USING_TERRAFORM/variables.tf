# -----------------------------
# Environment
# -----------------------------
variable "env" {
  description = "Environment name"
  type        = string
}

# -----------------------------
# VPC CIDR
# -----------------------------
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

# -----------------------------
# Availability Zones
# -----------------------------
variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

# -----------------------------
# Tags
# -----------------------------
variable "tags" {
  description = "Common Tags"
  type        = map(string)
}