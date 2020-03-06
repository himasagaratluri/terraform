variable "instance_type" {}

variable "pub_keypath" {}

variable "subnet_id" {}

variable "security_group_ports" { type = "map" }

variable "default_tags" { type = "map" }

variable "vpc_id" {}
