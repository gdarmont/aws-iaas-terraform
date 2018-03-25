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
  ttl = 10
  records = [
    "${aws_instance.test.public_ip}"
  ]
}