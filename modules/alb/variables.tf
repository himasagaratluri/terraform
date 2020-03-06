variable "alb_name" {
  default = "vm-alb"
}

variable "alb_serving" {
  default = "false"
  description = "Internal/external, false/true: respectively"
}

variable "alb_type" {
  default = "application"
}

variable "subnet_ids" {type="list"}

variable "security_group_id" {}

variable "default_tags" { type = "map" }

variable "termination_protection" {
  default = "false"
}

variable "acm_cert_arn" {type="string"}

variable "vpc_id" {}

variable "vm_app_port" {}

variable "vm_instance_id" {}

variable "alb_ssl_policy" {}
