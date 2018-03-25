###############################################################################
# Load balancer part
###############################################################################
resource "aws_lb" "test_lb" {
  name = "test-lb"
  load_balancer_type = "application"

  subnets = [
    "${data.aws_subnet.public_az_a.id}",
    "${data.aws_subnet.public_az_b.id}",
    "${data.aws_subnet.public_az_c.id}"
  ]

  security_groups = ["${data.aws_security_group.default.id}"]
}

resource "aws_lb_listener" "test_lb_listener" {
  load_balancer_arn = "${aws_lb.test_lb.arn}"
  port = "443"
  protocol = "HTTPS"
  certificate_arn   = "${aws_acm_certificate_validation.cert.certificate_arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.test_lb_tg.arn}"
    type = "forward"
  }
}

resource "aws_lb_target_group" "test_lb_tg" {
  name = "test-lb-tg"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = "${data.aws_vpc.default.id}"

  deregistration_delay = 30

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    protocol = "HTTP"
    port = "80"
    path = "/"
    interval = 5
    matcher = "200"
  }
}

###############################################################################
# Attachement part
###############################################################################
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.test_lb_tg.arn}"
  target_id        = "${aws_instance.test.id}"
  port             = 80
}