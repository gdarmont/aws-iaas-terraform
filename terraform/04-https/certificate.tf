resource "aws_acm_certificate" "cert" {
  domain_name = "*.awsdemo.fr"
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation" {
  zone_id = "${data.aws_route53_zone.awsdemo_fr.id}"
  name = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl = 10
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}