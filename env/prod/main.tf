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
