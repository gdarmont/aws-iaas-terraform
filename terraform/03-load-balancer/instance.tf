# Creating instance
resource "aws_instance" "test" {
  // AMI Id is region dependant
  // aws-iaas-simple-http-server (derived from amzn-ami-hvm-2017.09.1.20180307-x86_64-gp2)
  ami = "ami-05e22d2a2817c520a"
  subnet_id = "${aws_subnet.private_az_c.id}"
  instance_type = "t2.small"

  tags {
    env = "awsdemo"
  }
}
