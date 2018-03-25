# Retrieving default VPC
data "aws_vpc" "default" {
  default = "true"
}

# Retrieving subnet in Availability Zone "a" for default VPC
data "aws_subnet" "public_az_a" {
  availability_zone = "${var.region}a"
  vpc_id = "${data.aws_vpc.default.id}"
  default_for_az = true
}

# Retrieving subnet in Availability Zone "b" for default VPC
data "aws_subnet" "public_az_b" {
  availability_zone = "${var.region}b"
  vpc_id = "${data.aws_vpc.default.id}"
  default_for_az = true
}

# Retrieving subnet in Availability Zone "c" for default VPC
data "aws_subnet" "public_az_c" {
  availability_zone = "${var.region}c"
  vpc_id = "${data.aws_vpc.default.id}"
  default_for_az = true
}

# Retrieving default security group
data "aws_security_group" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
  name = "default"
}