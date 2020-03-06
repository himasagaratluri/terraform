provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}

/*
Got the filter values from:
  aws ec2 describe-images --image-id ami-0a887e401f7654935
*/
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20200207.1-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_ebs_volume" "instance_volume" {
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  size              = "20"

  tags = "${var.default_tags}"
}

resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.instance_volume.id}"
  instance_id = "${aws_instance.vm.id}"
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.default_tags["app"]}"
  public_key = "${file(var.pub_keypath)}"

  tags = "${var.default_tags}"
}

resource "aws_security_group" "vm_sg" {
  name        = "VM-SG"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpc_id}"

  tags = "${var.default_tags}"
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vm_sg.id}"
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  to_port           = "${var.security_group_ports["http"]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "${var.security_group_ports["http"]}"
  security_group_id = "${aws_security_group.vm_sg.id}"
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  to_port           = "${var.security_group_ports["https"]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "${var.security_group_ports["https"]}"
  security_group_id = "${aws_security_group.vm_sg.id}"
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  to_port           = "${var.security_group_ports["ssh"]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "${var.security_group_ports["ssh"]}"
  security_group_id = "${aws_security_group.vm_sg.id}"
}

resource "aws_instance" "vm" {
  ami                         = "${data.aws_ami.amazon_linux_2.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.auth.id}"
  vpc_security_group_ids             = ["${aws_security_group.vm_sg.id}"]
  associate_public_ip_address = "False"

  subnet_id = "${var.subnet_id}"

  tags = "${var.default_tags}"
}