module "aws_ec2" {
  source = "../../modules/ec2"

  // inputs to module
  instance_type = "t2.micro"

  // ssh-key-material
  pub_keypath = "~/.ssh/id_rsa.pub"

  // network configs
  vpc_id = "vpc-b853c8c2"
  subnet_id = "subnet-09abb443"

  //ports to expose
  security_group_ports = "${map(
    "http", "80",
    "https", "443"
    ,"ssh", "22"
  )}"

  //tags
  default_tags = "${map(
    "Name", "terri-project",
    "app", "terri-project-web-service",
    "env", "dev"
  )}"
}

module "acm_certificate" {
  source = "../../modules/acm"
  
  domain_name = "*.hatluri.com"
  
  //tags
  default_tags = "${map(
    "Name", "terri-project",
    "app", "terri-project-web-service",
    "env", "dev"
  )}"
}

module "application_lb" {
  source = "../../modules/alb"
  
  alb_name = "terriweb-service-alb"
  alb_type = "application"
  subnet_ids = ["subnet-09abb443","subnet-25b5fa42"]
  security_group_id = "sg-f10d29a9"
  termination_protection = "false"

  //tags
  default_tags = "${map(
    "Name", "terri-project",
    "app", "terri-project-web-service",
    "env", "dev"
  )}"
}
