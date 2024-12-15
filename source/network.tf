# vpc
resource "aws_vpc" "example" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "example"
  }
}

# public subnet
resource "aws_subnet" "public_0" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"
  tags = {
    Name = "public_0"
  }
}

# public subnet2
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"
  tags = {
    Name = "public_1"
  }
}

# internet gateway
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
  tags = {
    Name = "igw-test"
  }
}

# route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id
}

# route igw-table
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.example.id
  destination_cidr_block = "0.0.0.0/0"
}

# attach public subnet_0
resource "aws_route_table_association" "public_0" {
  subnet_id      = aws_subnet.public_0.id
  route_table_id = aws_route_table.public.id
}

# attach public subnet_1
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# plivate subnet
resource "aws_subnet" "plivate_0" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.1.64.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"
}

resource "aws_subnet" "plivate_1" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.1.128.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"
}

# plivate route table
resource "aws_route_table" "plivate_0" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route_table" "plivate_1" {
  vpc_id = aws_vpc.example.id
}

# plivate association
resource "aws_route_table_association" "plivate_0" {
  subnet_id      = aws_subnet.plivate_0.id
  route_table_id = aws_route_table.plivate_0.id
}

resource "aws_route_table_association" "plivate_1" {
  subnet_id      = aws_subnet.plivate_1.id
  route_table_id = aws_route_table.plivate_1.id
}

# eip
resource "aws_eip" "nat_gateway_0" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.example]
}

resource "aws_eip" "nat_gateway_1" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.example]
}

# nat
resource "aws_nat_gateway" "nat_gateway_0" {
  allocation_id = aws_eip.nat_gateway_0.id
  subnet_id     = aws_subnet.public_0.id
  depends_on    = [aws_internet_gateway.example]
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_gateway_1.id
  subnet_id     = aws_subnet.public_1.id
  depends_on    = [aws_internet_gateway.example]
}

# route
resource "aws_route" "plivate_0" {
  route_table_id         = aws_route_table.plivate_0.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_0.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "plivate_1" {
  route_table_id         = aws_route_table.plivate_1.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_1.id
  destination_cidr_block = "0.0.0.0/0"
}