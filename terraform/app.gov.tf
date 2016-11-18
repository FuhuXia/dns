resource "aws_route53_zone" "app_gov_zone" {
  name = "app.gov."
  tags {
    Project = "dns"
  }
}

resource "aws_s3_bucket" "app_gov_redirect_root" {
    bucket = "app.gov"
    acl = "public-read"
    website {
      redirect_all_requests_to = "https://apps.gov/"
    }
}

resource "aws_s3_bucket" "app_gov_redirect_www" {
    bucket = "www.app.gov"
    acl = "public-read"
    website {
      redirect_all_requests_to = "https://www.apps.gov/"
    }
}

resource "aws_route53_record" "app_gov_app_gov_a" {
  zone_id = "${aws_route53_zone.app_gov_zone.zone_id}"
  name = "app.gov."
  type = "A"
  alias {
    name = "${aws_s3_bucket.app_gov_redirect_root.website_domain}"
    zone_id = "${aws_s3_bucket.app_gov_redirect_root.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "app_gov_www_app_gov_a" {
  zone_id = "${aws_route53_zone.app_gov_zone.zone_id}"
  name = "www.app.gov."
  type = "A"
  alias {
    name = "${aws_s3_bucket.app_gov_redirect_www.website_domain}"
    zone_id = "${aws_s3_bucket.app_gov_redirect_www.hosted_zone_id}"
    evaluate_target_health = false
  }
}

output "app_gov_ns" {
  value="${aws_route53_zone.app_gov_zone.name_servers}"
}