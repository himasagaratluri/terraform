
resource "aws_alb" "app_alb" {
  name               = "${var.alb_name}"
  internal           = "${var.alb_serving}"
  load_balancer_type = "${var.alb_type}"
  security_groups    = ["${var.security_group_id}"]
  subnets            = ["${var.subnet_ids}"]

  enable_deletion_protection = "${var.termination_protection}"

  tags = "${var.default_tags}"
}

resource "aws_alb_target_group" "ec2_target" {
  name        = "${var.alb_name}-tg"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.app_alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "${var.alb_ssl_policy}"
  certificate_arn   = "${var.acm_cert_arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.ec2_target.arn}"
  }

  depends_on = [
    "aws_alb.app_alb",
  ]
}

#Instance Attachment
resource "aws_alb_target_group_attachment" "vm_alb_binding" {
  depends_on = [
    "aws_alb_target_group.ec2_target",
  ]
  target_group_arn = "${aws_alb_target_group.ec2_target.arn}"
  target_id        = "${var.vm_instance_id}"  
  port             = "${var.vm_app_port}"
}
