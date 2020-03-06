output "alb_dns_name" {
  value = "${aws_alb.app_alb.dns_name}"
}
