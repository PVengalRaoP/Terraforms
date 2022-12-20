#VPC Creation

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true  
  tags = {
    Name        = var.tagname
    Environment = var.tagname
  }
}

#Subnet Creation

#Public

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)
  
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.public_subnet_cidr, count.index)
  map_public_ip_on_launch = true
  
  }

#Private
  
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.private_subnet_cidr, count.index)
  map_public_ip_on_launch = false
 
 }
 
#Route Table creation


resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.tagname}-private-route-table"
    Environment = "${var.tagname}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.tagname}-public-route-table"
    Environment = "${var.tagname}"
  }
}

resource "aws_route_table_association" "pub-rt-attach" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_route_table_association" "pvt-rt-attach" {
  count = length(var.private_subnet_cidr)
  subnet_id    = element(aws_subnet.private_subnet.*.id, count.index)  
  route_table_id = aws_route_table.private_rt.id
}

#IGW
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.tagname}-igw"
    Environment = "${var.tagname}"
  }
}
# Elastic IP for NAT 
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

#NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, 0)}"
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name        = "nat"
    Environment = "${var.tagname}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}
resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

resource "aws_security_group" "Sggroup-default" {
  name        = "${var.tagname}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Environment = "${var.tagname}"
  }
}