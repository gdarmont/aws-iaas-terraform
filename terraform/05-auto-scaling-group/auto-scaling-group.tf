resource "aws_launch_configuration" "test_lc" {
  name = "test-lc"
  image_id = "ami-05e22d2a2817c520a"
  instance_type = "t2.small"

  security_groups = [
    "${data.aws_security_group.default.id}"]

}

resource "aws_autoscaling_group" "test_asg" {
  name = "test_auto_scaling_group"
  launch_configuration = "${aws_launch_configuration.test_lc.name}"

  min_size = "1"
  max_size = "10"
  desired_capacity = "5"

  health_check_type = "EC2"
  # Load balancer Target Group association
  target_group_arns = [
    "${aws_lb_target_group.test_lb_tg.arn}"]

  vpc_zone_identifier = [
    "${aws_subnet.private_az_a.id}",
    "${aws_subnet.private_az_b.id}",
    "${aws_subnet.private_az_c.id}"
  ]

  tag {
    key = "env"
    value = "awsdemo"
    propagate_at_launch = true
  }
}

# Below : add some rules to trigger upscaling or downscaling.