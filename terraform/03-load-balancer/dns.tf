# Retrieving pre-registered DNS zone
data "aws_route53_zone" "awsdemo_fr" {
  name         = "awsdemo.fr."
  private_zone = false
}

# DNS record creation
resource "aws_route53_record" "test_instance_public" {
  zone_id = "${data.aws_route53_zone.awsdemo_fr.zone_id}"
  name = "test.awsdemo.fr"
  type = "A"

  alias {
    name = "${aws_lb.test_lb.dns_name}"
    zone_id = "${aws_lb.test_lb.zone_id}"
    evaluate_target_health = true
  }
}

# DNS record creation
resource "aws_route53_record" "test_lb_public" {
  zone_id = "${data.aws_route53_zone.awsdemo_fr.zone_id}"
  // We could have use test.awsdemo.fr like before, but to avoid TTL issue in limited time, we just use another record
  name = "test-lb.awsdemo.fr"
  type = "A"

  alias {
    name = "${aws_lb.test_lb.dns_name}"
    zone_id = "${aws_lb.test_lb.zone_id}"
    evaluate_target_health = true
  }
}