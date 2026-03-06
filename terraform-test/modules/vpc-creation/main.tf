resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "sample_subnet" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
}
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}


resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.sample_subnet.id
  route_table_id = aws_route_table.name.id
}