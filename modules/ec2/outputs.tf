output "instance_ip_addr" {
  value = "${aws_instance.vm.private_ip}"
}