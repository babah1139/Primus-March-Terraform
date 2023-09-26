data "aws_ami" "amzn-linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-*"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "Primus-server" {
  ami                         = data.aws_ami.amzn-linux2.id
  instance_type               = var.instanceType               # "t2.micro"
  key_name                    = aws_key_pair.test-key.key_name #"terraform-key"
  subnet_id                   = aws_subnet.primus-subnet.id
  vpc_security_group_ids      = [aws_security_group.primus-sg.id]
  user_data                   = file(var.userData)
  user_data_replace_on_change = true
  count = 3

  tags = {
    Name = "Primus-server"
  }
}


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

resource "aws_security_group" "primus-sg" {
  name        = "primus-sg"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = aws_vpc.primus-vpc.id

  /* ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }*/

  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "primus-sg"
  }
}


resource "aws_key_pair" "test-key" {
  key_name   = "test-key"
  public_key = file(var.keyName)

}

