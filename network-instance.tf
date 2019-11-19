data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "ansible-demo"
  }

}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ansible-demo"
  }

}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "ansible-demo"
  }

}

resource "aws_subnet" "main" {
  cidr_block        = "10.0.0.0/24"
  vpc_id            = aws_vpc.main.id
  availability_zone = "${element(data.aws_availability_zones.available.names, 0)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "ansible-demo"
  }

}

resource "aws_route_table_association" "main" {
  route_table_id = aws_route_table.main.id
  subnet_id      = aws_subnet.main.id
}