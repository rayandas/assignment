resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_eip" "nat_ip" {
  vpc = true
}

resource "aws_subnet" "public1" {
  cidr_block        = "10.1.1.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.available1
}

resource "aws_subnet" "public2" {
  cidr_block        = "10.1.2.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.available1
}

resource "aws_subnet" "public3" {
  cidr_block        = "10.1.3.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.available2
}

resource "aws_subnet" "private1" {
  cidr_block        = "10.1.4.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.available2
}

resource "aws_subnet" "private2" {
  cidr_block        = "10.1.5.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.available3
}

resource "aws_subnet" "private3" {
  cidr_block        = "10.1.6.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.available3
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public1.id
  depends_on    = [aws_internet_gateway.internet_gateway, aws_eip.nat_ip, aws_subnet.private1, aws_subnet.private2]
}

resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_route_table" "route-private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  depends_on = [aws_nat_gateway.nat_gateway]
}

resource "aws_route_table_association" "private-association" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.route-private.id
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "main_subnet_group"
  description = "Our main group of subnets"
  subnet_ids  = [aws_subnet.private1.id, aws_subnet.private2.id]
}

resource "aws_security_group" "security" {
  name   = "security_group"
  vpc_id = aws_vpc.vpc.id
    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      description = "Postgesql"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
}
