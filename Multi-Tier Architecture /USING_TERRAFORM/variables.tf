variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Public Subnets
variable "public_subnet_1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2" {
  default = "10.0.2.0/24"
}

# App Subnets
variable "private_app_subnet_1" {
  default = "10.0.11.0/24"
}

variable "private_app_subnet_2" {
  default = "10.0.12.0/24"
}

# DB Subnets
variable "private_db_subnet_1" {
  default = "10.0.21.0/24"
}

variable "private_db_subnet_2" {
  default = "10.0.22.0/24"
}

# Cache Subnets
variable "private_cache_subnet_1" {
  default = "10.0.31.0/24"
}

variable "private_cache_subnet_2" {
  default = "10.0.32.0/24"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "db_username" {
  default = "prodadmin"
}