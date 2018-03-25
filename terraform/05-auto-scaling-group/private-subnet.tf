# A private subnet is a subnet without no route to internet gateway
resource "aws_subnet" "private_az_a" {
  vpc_id = "${data.aws_vpc.default.id}"
  availability_zone = "${data.aws_subnet.public_az_a.availability_zone}"
  cidr_block = "${cidrsubnet(data.aws_vpc.default.cidr_block, 4, 3)}"
}

resource "aws_subnet" "private_az_b" {
  vpc_id = "${data.aws_vpc.default.id}"
  availability_zone = "${data.aws_subnet.public_az_b.availability_zone}"
  cidr_block = "${cidrsubnet(data.aws_vpc.default.cidr_block, 4, 4)}"
}

resource "aws_subnet" "private_az_c" {
  vpc_id = "${data.aws_vpc.default.id}"
  availability_zone = "${data.aws_subnet.public_az_c.availability_zone}"
  cidr_block = "${cidrsubnet(data.aws_vpc.default.cidr_block, 4, 5)}"
}

# A route table without any specific route. Default route for internal VPC communication is automatically added
resource "aws_route_table" "private" {
  vpc_id = "${data.aws_vpc.default.id}"
}

# Private subnet to route association
resource "aws_route_table_association" "private_a_route_assoc" {
  subnet_id = "${aws_subnet.private_az_a.id}"
  route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "private_b_route_assoc" {
  subnet_id = "${aws_subnet.private_az_b.id}"
  route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "private_c_route_assoc" {
  subnet_id = "${aws_subnet.private_az_c.id}"
  route_table_id = "${aws_route_table.private.id}"
}