resource "aws_vpc" "primus-vpc" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "primus-vpc"
  }
}


resource "aws_subnet" "primus-subnet" {
  vpc_id            = aws_vpc.primus-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.avZone

  map_public_ip_on_launch = true

  tags = {
    Name = "primus-sbn"
  }
}


resource "aws_internet_gateway" "primus-gw" {
  vpc_id = aws_vpc.primus-vpc.id

  tags = {
    Name = "primus-igw"
  }
}


resource "aws_route_table" "primus-pub-rt" {
  vpc_id = aws_vpc.primus-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primus-gw.id
  }

  tags = {
    Name = "primus-pub-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.primus-subnet.id
  route_table_id = aws_route_table.primus-pub-rt.id
}