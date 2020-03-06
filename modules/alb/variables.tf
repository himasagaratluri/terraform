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
