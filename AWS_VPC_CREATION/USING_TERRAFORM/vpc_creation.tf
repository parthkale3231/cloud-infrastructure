# -----------------------------
# VPC
# -----------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.tags,
    {
      Name = "${var.env}-vpc"
    }
  )
}

# -----------------------------
# Public Subnets
# -----------------------------
resource "aws_subnet" "public" {
  count = length(var.azs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-${var.azs[count.index]}"
  }
}

# -----------------------------
# Private App Subnets
# -----------------------------
resource "aws_subnet" "private_app" {
  count = length(var.azs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 10)
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.env}-private-app-${var.azs[count.index]}"
  }
}

# -----------------------------
# Internet Gateway
# -----------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# -----------------------------
# Elastic IPs for NAT Gateway
# -----------------------------
resource "aws_eip" "nat" {
  count  = length(var.azs)
  domain = "vpc"

  tags = {
    Name = "${var.env}-eip-${count.index}"
  }
}

# -----------------------------
# NAT Gateways
# -----------------------------
resource "aws_nat_gateway" "ngw" {
  count = length(var.azs)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.env}-ngw-${count.index}"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}