resource "aws_vpc" "tf_vpc" {
  cidr_block           = "172.123.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "CustomVPC"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  cidr_block              = "172.123.1.0/24"
  vpc_id                  = aws_vpc.tf_vpc.id
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "tf_public_subnet_2" {
  cidr_block              = "172.123.10.0/24"
  vpc_id                  = aws_vpc.tf_vpc.id
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
  tags = {
    Name = "PublicSubnet2"
  }
}

resource "aws_internet_gateway" "tf_gw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "CustomVPC_IGW"
  }
}


resource "aws_route_table" "tf_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "CustomVPC_public_rt"
  }
}

resource "aws_route" "tf_route" {
  route_table_id         = aws_route_table.tf_rt.id
  gateway_id             = aws_internet_gateway.tf_gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "tf_subnet_rt_ast" {
  subnet_id      = aws_subnet.tf_public_subnet.id
  route_table_id = aws_route_table.tf_rt.id
}


resource "aws_route_table_association" "tf_subnet_rt_ast_2" {
  subnet_id      = aws_subnet.tf_public_subnet_2.id
  route_table_id = aws_route_table.tf_rt.id
}
