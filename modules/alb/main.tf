
resource "aws_lb" "app_alb" {
  name               = "${var.alb_name}"
  internal           = "${var.alb_serving}"
  load_balancer_type = "${var.alb_type}"
  security_groups    = ["${var.security_group_id}"]
  subnets            = ["${var.subnet_ids}"]

  enable_deletion_protection = "${var.termination_protection}"

  tags = "${var.default_tags}"
}