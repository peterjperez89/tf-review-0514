//route53 hosted private zone
resource "aws_route53_zone" "privatezone" {
  name          = "atlas.local"
  force_destroy = true

  vpc {
    vpc_id = var.vpc
  }
}

//route53 record
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.privatezone.id
  name    = "atlas.local"
  type    = "A"
  records = [var.privateip]
  ttl     = 300
}