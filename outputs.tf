output "plauground.public_ip" {
  value = "${aws_instance.plauground.*.public_ip}"
}

output "plauground.public_dns" {
  value = "${aws_instance.plauground.*.public_dns}"
}
