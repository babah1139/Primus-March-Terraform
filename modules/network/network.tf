resource "aws_vpc" "primus-vpc" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.name}"
  }
}


resource "aws_subnet" "primus-subnet" {
  vpc_id            = aws_vpc.primus-vpc.id
  cidr_block        = var.sbn-cidr
  availability_zone = var.avZone

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-sbn"
  }
}


resource "aws_internet_gateway" "primus-gw" {
  vpc_id = aws_vpc.primus-vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}


resource "aws_route_table" "primus-pub-rt" {
  vpc_id = aws_vpc.primus-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primus-gw.id
  }

  tags = {
    Name = "${var.name}-pub-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.primus-subnet.id
  route_table_id = aws_route_table.primus-pub-rt.id
}