resource "aws_vpc" "reworking_dev_vpc" {
  cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "reworking_dev_public_subnet" {
  vpc_id            = aws_vpc.reworking_dev_vpc.id
  cidr_block        = "192.168.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "reworking_dev_private_subnet" {
  vpc_id            = aws_vpc.reworking_dev_vpc.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "reworking_dev_gw" {
  vpc_id = aws_vpc.reworking_dev_vpc.id
  tags = {
    Name = "reworking-dev-gw"
  }
}

resource "aws_route_table" "reworking_dev_route_table" {
  vpc_id = aws_vpc.reworking_dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.reworking_dev_gw.id
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.reworking_dev_gw.id
  }


  tags = {
    Name = "reworking-dev-route-table"
  }
}

resource "aws_route_table_association" "reworking_dev_route_table_association" {
  subnet_id      = aws_subnet.reworking_dev_public_subnet.id
  route_table_id = aws_route_table.reworking_dev_route_table.id
}
