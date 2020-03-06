provider "aws" {
    region = "us-east-1"
}

module "aws_ec2" {
  source = "../../modules/ec2"

  // inputs to module
  instance_type = "${var.instance_type}"

  // ssh-key-material
  pub_keypath = "~/.ssh/id_rsa.pub"

  // network configs
  vpc_id = "${var.infra_vpc_id}"
  subnet_id = "${var.ec2_subnet_id}"

  //ports to expose
  security_group_ports = "${map(
    "http", "80",
    "https", "443"
    ,"ssh", "22"
  )}"

  //tags
  default_tags = "${map(
    "Name", "${var.application_name}-project",
    "app", "${var.application_name}-project-web-service",
    "env", "${var.tier}"
  )}"
}

module "acm_certificate" {
  source = "../../modules/acm"
  
  domain_name = "*.${var.org_domain}"
  
  //tags
  default_tags = "${map(
    "Name", "${var.application_name}-project",
    "app", "${var.application_name}-project-web-service",
    "env", "${var.tier}"
  )}"
}

module "application_alb" {

  source = "../../modules/alb"
  
  alb_name = "${var.application_name}-service-alb"
  alb_type = "application"
  subnet_ids = "${var.alb_subnet_ids}"
  security_group_id = "${module.aws_ec2.security_group_id}"
  termination_protection = "false"
  acm_cert_arn = "${module.acm_certificate.cert_acm_certificate_arn}"
  vpc_id = "${var.infra_vpc_id}"
  vm_app_port = "${var.application_port}"
  vm_instance_id = "${module.aws_ec2.instance_id}"
  alb_ssl_policy = "ELBSecurityPolicy-2016-08"

  //tags
  default_tags = "${map(
    "Name", "${var.application_name}-project",
    "app", "${var.application_name}-project-web-service",
    "env", "${var.tier}"
  )}"
}
