variable "infra_vpc_id" {
  default = "vpc-b853c8c2"
}

variable "application_name" {
  default = "terriweb"
}

variable "tier" {
  default = "dev"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "org_domain" {
  default = "hatluri.com"
}

variable "alb_subnet_ids" {
  type = "list"

  default = [
      "subnet-09abb443",
      "subnet-25b5fa42"
  ]
}
variable "ec2_subnet_id" {
  default = "subnet-09abb443"
}

variable "application_port" {
  default = "8080"
}
