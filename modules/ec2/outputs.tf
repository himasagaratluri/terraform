output "instance_ip_addr" {
  value = "${aws_instance.vm.private_ip}"
}

output "instance_id" {
  value = "${aws_instance.vm.id}"
}

output "security_group_id" {
  value = "${aws_security_group.vm_sg.id}"
}
