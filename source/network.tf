# vpc
resource "aws_vpc" "example" {
	cidr_block = "10.0.0.0/16"
	enable_dns_support = true
	enable_dns_hostnames = true

	tags = {
		Name = "example"
	}
}

# public subnet
resource "aws_subnet" "public" {
	vpc_id = aws_vpc.example.id
	cidr_block = "10.0.0.0/24"
	map_public_ip_on_launch = true
	availability_zone = "ap-northeast-1a"
	tags = {
		Name = "public"
	}
}

/*
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

resource "aws_route" "public" {
        route_table_id = aws_route_table.public.id
        gateway_id = aws_internet_gateway.example.id
        destination_cidr_block = "0.0.0.0/0"      
}

# attach public subnet
resource "aws_route_table_association" "public" {
        subnet_id = aws_subnet.public.id
        route_table_id = aws_route_table.public.id
} 

# plivate subnet
resource "aws_subnet" "plivate" {
	vpc_id = aws_vpc.example.id
	cidr_block = "10.0.64.0/24"
	map_public_ip_on_launch = false
	availability_zone = "ap-northeast-1a"
}

# plivate route
resource "aws_route_table" "plivate" {
	vpc_id = aws_vpc.example.id
}

# plivate association
resource "aws_route_table_association" "plivate" {
	subnet_id = aws_subnet.plivate.id
	route_table_id = aws_route_table.plivate.id
}

# eip
resource "aws_eip" "nat_gateway" {
	vpc = true
	depends_on = [aws_internet_gateway.example]
}

# nat
resource "aws_nat_gateway" "example" {
	allocation_id = aws_eip.nat_gateway.id
	subnet_id = aws_subnet.public.id
	depends_on = [aws_internet_gateway.example]
}

# root
resource "aws_route" "plivate" {
	route_table_id = aws_route_table.plivate.id
	nat_gateway_id = aws_nat_gateway.example.id
	destination_cidr_block = "0.0.0.0/0"
}
*/