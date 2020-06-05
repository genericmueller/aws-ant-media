# define our VPC (virtual private cloud)
resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "vpc"
  }
}

# define subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.default.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet"
  }
}

# define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "vpc internet gateway"
  }
}

# define the public routing table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public subnet routing table"
  }
}

# assign the routing table to public subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public-rt.id
}

# define the security group
resource "aws_security_group" "public" {
  name = "vpc_public"
  description = "allow incoming HTTP/HTTPS connections"
  vpc_id=aws_vpc.default.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 1935
    to_port = 1935
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5080
    to_port = 5080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5443
    to_port = 5443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5554
    to_port = 5554
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5000
    to_port = 65000
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security group"
  }
}