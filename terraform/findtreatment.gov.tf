resource "aws_route53_zone" "findtreatment_toplevel" {
  name = "findtreatment.gov"

  tags {
    Project = "dns"
  }
}

resource "aws_route53_record" "findtreatment_apex" {
  zone_id = "${aws_route53_zone.findtreatment_toplevel.zone_id}"
  name    = "findtreatment.gov."
  type    = "A"

  alias {
    name                   = "d3qgag0313dgk2.cloudfront.net."
    zone_id                = "${local.cloud_gov_cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "findtreatment_www" {
  zone_id = "${aws_route53_zone.findtreatment_toplevel.zone_id}"
  name    = "www.findtreatment.gov."
  type    = "A"

  alias {
    name                   = "d3qgag0313dgk2.cloudfront.net."
    zone_id                = "${local.cloud_gov_cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "findtreatment_gov__acme-challenge_findtreatment_gov_txt" {
  zone_id = "${aws_route53_zone.findtreatment_toplevel.zone_id}"
  name    = "_acme-challenge.findtreatment.gov."
  type    = "TXT"
  ttl     = 120
  records = ["7mbRC9tnaT3n20pIjnpFZ0WKcQJHxi6Rt7tdJjQaCvc"]
}

resource "aws_route53_record" "findtreatment_www_gov__acme-challenge_findtreatment_gov_txt" {
  zone_id = "${aws_route53_zone.findtreatment_toplevel.zone_id}"
  name    = "_acme-challenge.www.findtreatment.gov."
  type    = "TXT"
  ttl     = 120
  records = ["D0rV3DqJMU-UoUnr2ijbLAWmVScbnnPCPCDj-_5B970"]
}

# BOD
resource "aws_route53_record" "findtreatment_gov__dmarc_findtreatment_gov_txt" {
  zone_id = "${aws_route53_zone.findtreatment_toplevel.zone_id}"
  name    = "_dmarc.findtreatment.gov."
  type    = "TXT"
  ttl     = 300
  records = ["v=DMARC1; p=reject; pct=100; fo=1; ri=86400; rua=mailto:reports@dmarc.cyber.dhs.gov,mailto:hhs@rua.agari.com; ruf=mailto:hhs@ruf.agari.com"]
}

# SPF
resource "aws_route53_record" "findtreatment_gov__spf_findtreatment_gov_txt" {
  zone_id = "${aws_route53_zone.findtreatment_toplevel.zone_id}"
  name    = "findtreatment.gov."
  type    = "TXT"
  ttl     = 300
  records = ["${local.spf_no_mail}"]
}

output "findtreatment_ns" {
  value = "${aws_route53_zone.findtreatment_toplevel.name_servers}"
}
