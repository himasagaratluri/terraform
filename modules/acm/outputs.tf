output "cert_acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = "${aws_acm_certificate.cert.arn}"
}

output "cert_acm_certificate_domain_validation_options" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = "${flatten(aws_acm_certificate.cert.*.domain_validation_options)}"
}

output "cert_acm_certificate_validation_emails" {
  description = "A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used."
  value       = "${flatten(aws_acm_certificate.cert.*.validation_emails)}"
}