resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "prod-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "prod-igw"
  }
}

# -----------------------------
# Public Subnets
# -----------------------------

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

# -----------------------------
# Private App Subnets
# -----------------------------

resource "aws_subnet" "private_app_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_1
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-app-1"
  }
}

resource "aws_subnet" "private_app_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_2
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-app-2"
  }
}

# -----------------------------
# Private DB Subnets
# -----------------------------

resource "aws_subnet" "private_db_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_1
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-db-1"
  }
}

resource "aws_subnet" "private_db_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_2
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-db-2"
  }
}

# -----------------------------
# Private Cache Subnets
# -----------------------------

resource "aws_subnet" "private_cache_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cache_subnet_1
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-cache-1"
  }
}

resource "aws_subnet" "private_cache_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cache_subnet_2
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-cache-2"
  }
}

# -----------------------------
# Elastic IP for NAT
# -----------------------------

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

# -----------------------------
# NAT Gateway
# -----------------------------

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "prod-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

# -----------------------------
# Public Route Table
# -----------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# -----------------------------
# Private Route Table
# -----------------------------

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_app_1" {
  subnet_id      = aws_subnet.private_app_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_app_2" {
  subnet_id      = aws_subnet.private_app_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_db_1" {
  subnet_id      = aws_subnet.private_db_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_db_2" {
  subnet_id      = aws_subnet.private_db_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_cache_1" {
  subnet_id      = aws_subnet.private_cache_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_cache_2" {
  subnet_id      = aws_subnet.private_cache_2.id
  route_table_id = aws_route_table.private.id
}