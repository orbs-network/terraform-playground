output "playground.public_ip" {
  value = "${aws_instance.playground.*.public_ip}"
}

output "playground.public_dns" {
  value = "${aws_instance.playground.*.public_dns}"
}
